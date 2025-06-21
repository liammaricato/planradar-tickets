class ReminderMailer < ApplicationMailer
  def reminder_email(user, ticket)
    @user = user
    @ticket = ticket
    mail(to: @user.mail, subject: "Reminder: Your ticket is due soon")
  end
end
