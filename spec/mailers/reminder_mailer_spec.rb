require "rails_helper"

RSpec.describe ReminderMailer, type: :mailer do
  describe "#reminder_email" do
    let(:user) { create(:user) }
    let(:ticket) { create(:ticket, user: user) }

    let(:mail) { ReminderMailer.reminder_email(ticket) }

    it "renders the headers" do
      expect(mail.subject).to eq("Reminder: Your ticket #{ticket.title} is due soon")
      expect(mail.to).to eq([ user.mail ])
      expect(mail.from).to eq([ "tickets-reminder@planradar.com" ])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hello #{user.name}")
      expect(mail.body.encoded).to match(ticket.title)
      expect(mail.body.encoded).to match("Due date: #{ticket.due_date.strftime('%Y-%m-%d')}")
    end

    it "delivers the email" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
