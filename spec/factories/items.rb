FactoryBot.define do

  factory :item do
    name                  {"アイテム"}
    condition             {"新品、未使用"}
    price                 {"1000"}
    detail                {"アイテムです"}
    status_id             {"1"}
    created_at            { Faker::Time.between(2.days.ago, Time.now, :all) }
    user
  end

end
