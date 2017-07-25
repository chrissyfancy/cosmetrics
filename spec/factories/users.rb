FactoryGirl.define do
  factory :user do
    first_name "Chrissy"
    last_name "Fancy"
    role "member"
    sequence(:email) { |n| "test#{n}@test.com"}
    password "password"
  end
end
