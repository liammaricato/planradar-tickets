class ApplicationMailer < ActionMailer::Base
  default from: "tickets-reminder@planradar.com"
  layout "mailer"
end
