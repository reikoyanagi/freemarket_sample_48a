FactoryBot.define do

  factory :address do
    phone_number                {"00000000000"}
    post_code                   {"0000000"}
    prefecture_id               {"1"}
    city                        {"渋谷区"}
    block                       {"道玄坂２丁目２３−１２"}
    building                    {"フォンティスビル7F"}
    user
  end

end
