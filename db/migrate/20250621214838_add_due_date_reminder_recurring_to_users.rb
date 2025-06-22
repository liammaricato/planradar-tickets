class AddDueDateReminderRecurringToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :due_date_reminder_recurring, :boolean, default: false
  end
end
