FactoryBot.define do
  factory :user do
    name "Test User"
    email "test@example.com"
    password "please1234567890"

    transient do
      thought_count 5
    end

    after(:create) do |user, evaluator|
      create_list(:thought, evaluator.thought_count, user: user)
    end
  end
end
