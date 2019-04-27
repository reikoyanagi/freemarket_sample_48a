FactoryBot.define do

  factory :item do
    name                  { Faker::Name.name }
    condition             { Faker::Lorem.sentence }
    price                 { Faker::Number.number(4) }
    detail                { Faker::Lorem.sentence }
    status_id             {"1"}
    created_at            { Faker::Time.between(2.days.ago, Time.now, :all) }
    user
  end

end
