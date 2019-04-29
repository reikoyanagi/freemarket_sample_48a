class CreditCardsController < ApplicationController

  before_action :authenticate_user!
  require "payjp"

  def index
    credit = CreditCard.where(user_id: current_user.id).first
    # if credit.present?
    #   redirect_to action: "show"
    # end
  end

  def show
    credit = CreditCard.where(user_id: current_user.id).first
      Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
      customer = Payjp::Customer.retrieve(credit.customer_id)
      @default_card_infomation = customer.cards.retrieve(credit.card_id)
  end

  def new
    credit = CreditCard.where(user_id: current_user.id)
  end


  def create
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
    @credit = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
    if @credit.save
      redirect_to action: "show"
    else
      redirect_to action: "create"
    end

  end

  def delete
    credit = CreditCard.where(user_id: current_user.id).first
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.retrieve(credit.customer_id)
    @default_card_infomation = customer.cards.retrieve(credit.card_id)
    customer.delete
    credit.delete
  end

end
