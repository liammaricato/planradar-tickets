require 'rails_helper'

RSpec.describe Notifiers::Mail do
  let(:ticket) { create(:ticket) }
  let(:notifier) { described_class.new(ticket) }
  let(:mailer_double) { double('ReminderMailer') }

  describe 'inheritance' do
    it 'inherits from Notifiers::Base' do
      expect(described_class).to be < Notifiers::Base
    end

    it 'can access ticket through inherited attr_reader' do
      expect(notifier.send(:ticket)).to eq(ticket)
    end
  end

  describe '#notify!' do
    subject { notifier.notify! }

    it 'sends reminder email through ReminderMailer' do
      expect(ReminderMailer).to receive(:reminder_email).with(ticket).and_return(mailer_double)
      expect(mailer_double).to receive(:deliver_later)

      subject
    end
  end
end
