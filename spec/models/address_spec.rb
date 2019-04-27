require 'rails_helper'

describe Address do
  describe '#create' do
    #phone_numberが空である場合登録できないか
    it "is invalid without a phone_number" do
      address = build(:address, phone_number: nil)
      address.valid?
      expect(address.errors[:phone_number]).to include("can't be blank")
    end

    #post_codeが空である場合登録できないか
    it "is invalid without a post_cord" do
      address = build(:address, post_code: nil)
      address.valid?
      expect(address.errors[:post_code]).to include("can't be blank")
    end

    #prefecture_idが空である場合登録できないか
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("can't be blank")
    end

    #cityが空である場合登録できないか
    it "is invalid without a city" do
      address = build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    #blockが空である場合登録できないか
    it "is invalid without a block" do
      address = build(:address, block: nil)
      address.valid?
      expect(address.errors[:block]).to include("can't be blank")
    end

    #DBに保存されたかどうか
    it "is valid with a phone_number, post_code, prefecture_id, city, block, building, user_id" do
      user = build(:user)
      address = build(:address)
      expect(address).to be_valid
    end

  end
end
