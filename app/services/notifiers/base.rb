module Notifiers
  class Base
    def initialize(ticket)
      @ticket = ticket
    end

    def notify!
      raise NotImplementedError
    end

    private

    attr_reader :ticket
  end
end