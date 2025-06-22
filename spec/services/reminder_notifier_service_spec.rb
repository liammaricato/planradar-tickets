require 'rails_helper'

RSpec.describe ReminderNotifierService do
  let(:ticket) { create(:ticket) }
  let(:strategy) { :mail }

  describe '#initialize' do
    subject { described_class.new(ticket, strategy: strategy) }

    it 'sets the ticket and strategy' do
      expect(subject.instance_variable_get(:@ticket)).to eq(ticket)
      expect(subject.instance_variable_get(:@strategy)).to eq(:mail)
    end

    it 'uses default strategy when not specified' do
      expect(subject.instance_variable_get(:@strategy)).to eq(described_class::DEFAULT_STRATEGY)
    end
  end

  describe '#notify!' do
    subject { described_class.new(ticket, strategy: strategy).notify! }

    it 'delegates to the appropriate notifier' do
      expect_any_instance_of(Notifiers::Mail).to receive(:notify!).once

      subject
    end

    context 'when unsupported strategy' do
      let(:strategy) { :sms }

      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, "Notifier #{strategy} not found")
      end
    end
  end
end
