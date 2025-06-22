require 'rails_helper'

RSpec.describe Notifiers::Base do
  let(:ticket) { create(:ticket) }
  let(:notifier) { described_class.new(ticket) }

  describe '#notify!' do
    it 'raises NotImplementedError' do
      expect { notifier.notify! }.to raise_error(NotImplementedError)
    end
  end
end 