FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password }
    password_confirmation { Faker::Internet.password }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        {"タナカ"}
    first_name_kana       {"タロウ"}
    birth_date            {"2000-12-30"}
    avator                {""}
  end

end
