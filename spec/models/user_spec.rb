require 'rails_helper'

describe User do
  describe '#create' do
    #nicknameが空である場合登録できないか
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    #passwordが空である場合登録できないか
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    #password_confirmationが一致していない場合登録できないか
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("が一致しません")
    end

    #last_nameが空である場合登録できないか
    it "is invalid without a last_name" do
      user = build(:user, last_name: nil)
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください")
    end

    #first_nameが空である場合登録できないか
    it "is invalid without a first_name" do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    #last_name_kanaが空である場合登録できないか
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: nil)
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください")
    end

    #first_name_kanaが空である場合登録できないか
    it "is invalid without a first_name_kana" do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    #birth_dateが空である場合登録できないか
    it "is invalid without a birth_date" do
      user = build(:user, birth_date: nil)
      user.valid?
      expect(user.errors[:birth_date]).to include("を入力してください")
    end

    #passwordが5文字以下だと登録できないか
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password][0]).to include("is too short")
    end

    #DBに保存されたかどうか
    it "is valid with a nickname, password, password_confirmation, last_name, first_name, last_name_kana, first_name_kana, birth_date" do
      user = build(:user)
      expect(user).to be_valid
    end


  end
end
