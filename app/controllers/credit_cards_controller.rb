class CreditCardsController < ApplicationController

  before_action :authenticate_user!
  require "payjp"

  def index
  end

  def show
    credit = CreditCard.where(user_id: current_user.id).first
  end

  def new
    @credit = CreditCard.where(user_id: current_user.id)
  end


  def create
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.create(
      card: params['payjp-token'],
      )
    @credit = CreditCard.new(user_id: current_user.id, token_id: customer.default_card)
    if @credit.save
      redirect_to action: "show"
    else
      redirect_to action: "create"
    end

  end

  private
  def credit_params
    params.permit(:token_id).merge(id: current_user.id)
  end

end
