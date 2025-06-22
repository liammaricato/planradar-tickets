module Notifiers
  class Mail < Base
    def notify!
      ReminderMailer.reminder_email(ticket).deliver_later
    end
  end
end
