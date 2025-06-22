require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:mail) }
  end

  describe 'associations' do
    it { should have_many(:tickets).dependent(:destroy) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'has a valid factory with tickets' do
      user = create(:user, :with_tickets)
      expect(user.tickets.count).to eq(3)
    end

    it 'has a valid factory without reminders' do
      user = create(:user, :without_reminders)
      expect(user.send_due_date_reminder).to be false
    end

    it 'has a valid factory with recurring reminders' do
      user = create(:user, :recurring_reminders)
      expect(user.due_date_reminder_recurring).to be true
    end
  end

  describe 'default values' do
    let(:user) { create(:user) }

    it 'sets default values correctly' do
      expect(user.send_due_date_reminder).to be true
      expect(user.due_date_reminder_interval).to eq(0)
      expect(user.due_date_reminder_recurring).to be false
      expect(user.timezone).to eq('0')
      expect(user.due_date_reminder_time.strftime('%H:%M')).to eq('09:00')
    end
  end
end
