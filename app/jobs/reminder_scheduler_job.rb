class ReminderSchedulerJob < ApplicationJob
  queue_as :default

  def perform
    Ticket.notifiable.due_soon.find_each do |ticket|
      ticket.reminder_notify! if ticket.reminder_due?
    end
  end
end
