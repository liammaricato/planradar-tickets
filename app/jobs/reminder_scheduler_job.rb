class ReminderSchedulerJob < ApplicationJob
  queue_as :default

  def perform
    Ticket.notifiable.due_soon.find_each do |ticket|
      next unless ticket.reminder_due?

      ReminderMailer.reminder_email(ticket).deliver_later
    end
  end
end
