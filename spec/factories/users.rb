FactoryBot.define do
  factory :user do
    sequence(:mail) { |n| "user#{n}@example.com" }
    sequence(:name) { |n| "User #{n}" }
    timezone { "0" }
    due_date_reminder_time { "09:00" }
    due_date_reminder_recurring { false }
    due_date_reminder_interval { 0 }
    send_due_date_reminder { true }

    trait :with_tickets do
      after(:create) do |user|
        create_list(:ticket, 3, user: user)
      end
    end

    trait :without_reminders do
      send_due_date_reminder { false }
    end

    trait :recurring_reminders do
      due_date_reminder_recurring { true }
    end
  end
end
