class Ticket < ApplicationRecord
  belongs_to :user

  delegate :timezone, :due_date_reminder_time, to: :user

  scope :notifiable, -> { includes(:user).where(users: { send_due_date_reminder: true }) }
  scope :due_soon, -> { where('due_date <= ?', Time.current + 7.days) }

  def reminder_datetime_with_zone
    @reminder_datetime_with_zone ||=
      TimezoneUtils.to_utc_datetime(due_date, due_date_reminder_time, timezone)
  end

  def reminder_due?
    reminder_datetime_with_zone <= Time.current
  end
end
