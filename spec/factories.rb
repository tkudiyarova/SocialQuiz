FactoryGirl.define do
  factory :user do
    name     "tanya"
    email    "tanya1@gmail.com"
    password "1234567890"
    password_confirmation "1234567890"
  end

  factory :question do
    title "What is your name"
    user
  end
end