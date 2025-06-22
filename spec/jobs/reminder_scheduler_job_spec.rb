require 'rails_helper'

RSpec.describe ReminderSchedulerJob, type: :job do
  describe '#perform' do
    let(:user) { create(:user) }

    subject { described_class.perform_now }

    context 'when the ticket has a reminder due' do
      let!(:ticket) { create(:ticket, user: user) }

      before do
        allow_any_instance_of(Ticket).to receive(:reminder_due?).and_return(true)
      end

      it 'processes only eligible tickets' do
        expect_any_instance_of(Ticket).to receive(:reminder_notify!)

        subject
      end
    end

    context 'when user has reminders disabled' do
      let(:user_without_reminders) { create(:user, :without_reminders) }
      let!(:ticket) { create(:ticket, user: user_without_reminders) }

      it 'does not find any tickets for users with disabled reminders' do
        expect_any_instance_of(Ticket).not_to receive(:reminder_due?)
        expect_any_instance_of(Ticket).not_to receive(:reminder_notify!)

        subject
      end
    end
  end
end
