class ReminderMailer < ApplicationMailer
  def reminder_email(ticket)
    @ticket = ticket
    @user = ticket.user
    mail(to: @user.mail, subject: "Reminder: Your ticket #{@ticket.title} is due soon")
  end
end
