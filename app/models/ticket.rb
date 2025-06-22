class Ticket < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :due_date, presence: true

  enum :status_id, {
    open: 0,
    notified: 1,
    done: 2
  }
  
  alias_attribute :status, :status_id
  
  delegate :timezone, :due_date_reminder_time, :due_date_reminder_recurring,
           :due_date_reminder_interval, to: :user

  scope :not_notified, -> { where(status: :open) }
  scope :due_soon, -> { where('due_date <= ?', Time.current + 7.days) }
  scope :notifiable, -> do
    includes(:user)
      .where(users: { send_due_date_reminder: true })
      .where(
        arel_table[:status_id].eq(status_ids[:open])
        .or(User.arel_table[:due_date_reminder_recurring].eq(true))
      )
  end

  def reminder_datetime_with_zone
    @reminder_datetime_with_zone ||= begin
      due_datetime_utc = TimezoneUtils.to_utc_datetime(due_date, due_date_reminder_time, timezone)
      reminder_offset = due_date_reminder_interval.days

      due_datetime_utc - reminder_offset
    end
  end

  def reminder_due?
    reminder_datetime_with_zone <= Time.current
  end

  def reminder_notify!
    ReminderNotifierService.new(self).notify!
    update(status: :notified)
  end
end
