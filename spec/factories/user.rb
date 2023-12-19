FactoryBot.define do
  password = Faker::Internet.password  

  factory :user do
    username { Faker::Internet.username(specifier: 6..10) }
    email { Faker::Internet.email }
    password { password }
    password_confirmation { password }
  end
end
