FactoryBot.define do

  factory :user do
    nickname              {Faker::Name.name}
    password = Faker::Internet.password(6)
    password {password}
    password_confirmation {password}
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        {"タナカ"}
    first_name_kana       {"タロウ"}
    email                 { Faker::Internet.free_email }
    birth_date            {Faker::Time.between(DateTime.now - 1, DateTime.now).strftime("%D")}
    avator                { Faker::Avatar.image }
  end
end
