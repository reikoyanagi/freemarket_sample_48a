FactoryBot.define do

  factory :address do
    phone_number                {Faker::PhoneNumber.phone_number}
    post_code                   {Faker::Address.postcode}
    prefecture_id               {Faker::Number.digit}
    city                        {Faker::Address.city}
    block                       {Faker::Address.street_name}
    user_id                     {Faker::Number.digit}
  end

end
