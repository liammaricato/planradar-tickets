require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:due_date) }
  end

  describe 'enums' do
    it { should define_enum_for(:status_id).with_values(open: 0, notified: 1, done: 2) }
  end

  describe 'aliases' do
    it 'aliases status to status_id' do
      ticket = build(:ticket)
      expect(ticket.status).to eq(ticket.status_id)
    end
  end

  describe 'delegations' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket, user: user) }

    it 'delegates timezone to user' do
      expect(ticket.timezone).to eq(user.timezone)
    end

    it 'delegates due_date_reminder_time to user' do
      expect(ticket.due_date_reminder_time).to eq(user.due_date_reminder_time)
    end

    it 'delegates due_date_reminder_recurring to user' do
      expect(ticket.due_date_reminder_recurring).to eq(user.due_date_reminder_recurring)
    end

    it 'delegates due_date_reminder_interval to user' do
      expect(ticket.due_date_reminder_interval).to eq(user.due_date_reminder_interval)
    end
  end

  describe 'scopes' do
    let!(:open_ticket) { create(:ticket, status: :open) }
    let!(:notified_ticket) { create(:ticket, status: :notified) }
    let!(:done_ticket) { create(:ticket, status: :done) }

    describe '.not_notified' do
      it 'returns only open tickets' do
        expect(Ticket.not_notified).to include(open_ticket)
        expect(Ticket.not_notified).not_to include(notified_ticket, done_ticket)
      end
    end

    describe '.due_soon' do
      let!(:due_soon_ticket) { create(:ticket, due_date: 3.days.from_now) }
      let!(:due_later_ticket) { create(:ticket, due_date: 10.days.from_now) }

      it 'returns tickets due within 7 days' do
        expect(Ticket.due_soon).to include(due_soon_ticket)
        expect(Ticket.due_soon).not_to include(due_later_ticket)
      end
    end

    describe '.notifiable' do
      let(:user_with_reminders) { create(:user, send_due_date_reminder: true) }
      let(:user_without_reminders) { create(:user, send_due_date_reminder: false) }
      let(:user_with_recurring) { create(:user, send_due_date_reminder: true, due_date_reminder_recurring: true) }

      let!(:notifiable_open_ticket) { create(:ticket, user: user_with_reminders, status: :open) }
      let!(:notifiable_notified_ticket) { create(:ticket, user: user_with_recurring, status: :notified) }
      let!(:non_notifiable_ticket) { create(:ticket, user: user_without_reminders, status: :open) }
      let!(:done_ticket_with_reminders) { create(:ticket, user: user_with_reminders, status: :done) }

      it 'returns tickets that are notifiable' do
        notifiable_tickets = Ticket.notifiable
        expect(notifiable_tickets).to include(notifiable_open_ticket, notifiable_notified_ticket)
        expect(notifiable_tickets).not_to include(non_notifiable_ticket, done_ticket_with_reminders)
      end
    end
  end

  describe '#reminder_datetime_with_zone' do
    let(:user) { create(:user, timezone: '0', due_date_reminder_time: '09:00', due_date_reminder_interval: 2) }
    let(:ticket) { create(:ticket, user: user, due_date: Date.new(2024, 1, 15)) }

    it 'calculates reminder datetime correctly' do
      expected_reminder_time = Time.utc(2024, 1, 13, 9, 0, 0) # 2 days before due date at 9 AM UTC
      expect(ticket.reminder_datetime_with_zone).to eq(expected_reminder_time)
    end

    context 'with different timezone' do
      let(:user) { create(:user, timezone: '-5', due_date_reminder_time: '14:00', due_date_reminder_interval: 1) }
      let(:ticket) { create(:ticket, user: user, due_date: Date.new(2024, 1, 15)) }

      it 'handles timezone conversion correctly' do
        # 14:00 in UTC-5 = 19:00 UTC, 1 day before due date
        expected_reminder_time = Time.utc(2024, 1, 14, 19, 0, 0)
        expect(ticket.reminder_datetime_with_zone).to eq(expected_reminder_time)
      end

      context 'when timezone respects DST' do
        let(:user) { create(:user, timezone: '5', due_date_reminder_time: '14:00', due_date_reminder_interval: 1) }
        let(:ticket) { create(:ticket, user: user, due_date: Date.new(2024, 1, 15)) }

        it 'handles timezone conversion correctly' do
          # 14:00 in UTC+5 (before DST) = 09:00 UTC, -1 hour difference from DST, 1 day before due date
          expected_reminder_time = Time.utc(2024, 1, 14, 8, 0, 0)
          expect(ticket.reminder_datetime_with_zone).to eq(expected_reminder_time)
        end
      end
    end
  end

  describe '#reminder_due?' do
    let(:user) { create(:user, timezone: '0', due_date_reminder_time: '09:00', due_date_reminder_interval: 1) }
    let(:ticket) { create(:ticket, user: user, due_date: Date.new(2024, 1, 15)) }

    context 'when reminder time has passed' do
      before do
        travel_to Time.utc(2024, 1, 14, 10, 0, 0) # After reminder time
      end

      after { travel_back }

      it 'returns true' do
        expect(ticket.reminder_due?).to be true
      end
    end

    context 'when reminder time has not passed' do
      before do
        travel_to Time.utc(2024, 1, 14, 8, 0, 0) # Before reminder time
      end

      after { travel_back }

      it 'returns false' do
        expect(ticket.reminder_due?).to be false
      end
    end

    context 'when reminder time is exactly now' do
      before do
        travel_to Time.utc(2024, 1, 14, 9, 0, 0) # Exactly at reminder time
      end

      after { travel_back }

      it 'returns true' do
        expect(ticket.reminder_due?).to be true
      end
    end
  end

  describe '#reminder_notify!' do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket, user: user, status: :open) }

    subject { ticket.reminder_notify! }

    it 'calls the notifier service' do
      expect(ReminderNotifierService).to receive(:new).with(ticket).and_return(double(notify!: true)).once
      subject
    end

    it 'updates status to notified' do
      expect { subject }.to change { ticket.reload.status }.from('open').to('notified')
    end
  end
end
