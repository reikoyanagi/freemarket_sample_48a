
FactoryBot.define do

  factory :image do
    item_image                 { Faker::Avatar.image }
    item
  end
end
