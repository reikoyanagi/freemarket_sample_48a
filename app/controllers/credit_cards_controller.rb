class CreditCardsController < ApplicationController

  before_action :authenticate_user!
  require "payjp"

  def index
    @credit_card = Credit_card.new
  end

  def show
    @credit_card = Credit_card_where(user_id: current_user.id).first
    if @credit_card.blank?
      redirect_to action: "new"
    end
  end

  def new
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    Payjp::Token.create({
      :card => {
        :number => '4242424242424242',
        :exp_month => '2',
        :exp_year => '2020',
        :cvc => '123'
      }},
      {
        'X-Payjp-Direct-Token-Generate': 'true'
      })
  end


  def create
    @credit_card = Credit_card.new(credit_params)
    @credit_card.save
  end

  private
  def credit_params
    params.require(:credit_card).permit(:token_id)
  end

end
