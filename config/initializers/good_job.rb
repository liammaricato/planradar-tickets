Rails.application.configure do
  config.good_job.enable_cron = true
  config.good_job.cron = {
    reminder_scheduler: {
      cron: '* * * * *', # Every minute
      class: 'ReminderSchedulerJob',
      description: 'Runs every minute to check for due date reminders'
    }
  }
end