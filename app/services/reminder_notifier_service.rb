class ReminderNotifierService
  DEFAULT_STRATEGY = :mail

  def initialize(ticket, strategy: DEFAULT_STRATEGY)
    @ticket = ticket
    @strategy = strategy
  end

  def notify!
    notifier.notify!
  end

  private

  def notifier
    @notifier ||= notifier_klass.new(ticket)
  end

  attr_reader :ticket, :strategy

  def notifier_klass
    case strategy
    when :mail
      Notifiers::Mail
    else
      raise "Notifier #{strategy} not found"
    end
  end
end
