class CreditCardsController < ApplicationController

  before_action :authenticate_user!
  require "payjp"

  def index #クレジットカードの追加画面
    credit = CreditCard.where(user_id: current_user.id).first
    # if credit.present?
    #   redirect_to action: "show"
    # end
  end

  def show #登録済みクレジットカードの表示画面
    credit = CreditCard.where(user_id: current_user.id).first
    if credit.blank?
      redirect_to action: "index"
    else
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447' #PayjpのAPIキー
    customer = Payjp::Customer.retrieve(credit.customer_id)
    @default_card_infomation = customer.cards.retrieve(credit.card_id)
    end
  end

  def new #クレジットカードのデータ入力（number等）画面
    credit = CreditCard.where(user_id: current_user.id)
  end



  def create #クレジットカードの作成処理（view無）
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.create(
      card: params['payjp-token'],
      ) #顧客作成の処理(参照Payjpリファレンス)
    @credit = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
    if @credit.save
      redirect_to action: "show"
    else
      redirect_to action: "create"
    end

  end

  def destroy #クレジットカードの削除処理（view無）
    credit = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.retrieve(credit.customer_id)
    card = customer.cards.retrieve(credit.card_id)
    customer = card
    customer.delete
    credit.delete
    redirect_to action: "index"
  end

end
