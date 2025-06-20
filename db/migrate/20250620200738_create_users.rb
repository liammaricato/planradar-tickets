class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :mail, null: false
      t.boolean :send_due_date_reminder, default: false
      t.integer :due_date_reminder_interval, default: 0
      t.time :due_date_reminder_time
      t.string :timezone

      t.timestamps
    end
  end
end
