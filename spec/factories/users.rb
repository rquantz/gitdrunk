require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    username { Faker::Name.first_name }
    role 'user'

    factory :admin_user do
      role 'admin'
    end
  end
end
