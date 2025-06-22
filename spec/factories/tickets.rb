FactoryBot.define do
  factory :ticket do
    association :user
    sequence(:title) { |n| "Ticket #{n}" }
    description { "This is a test ticket description" }
    due_date { 1.week.from_now }
    status { :open }

    trait :notified do
      status { :notified }
    end

    trait :done do
      status { :done }
    end

    trait :due_soon do
      due_date { 3.days.from_now }
    end

    trait :overdue do
      due_date { 1.day.ago }
    end

    trait :without_due_date do
      due_date { nil }
    end
  end
end
