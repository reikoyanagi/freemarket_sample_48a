class CreditCardsController < ApplicationController

  require "payjp"

  def index
  end

  def new
    # @user = User.new
    # Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    # Payjp::Token.create{
    #   :card => {
    #     :number => ""
    #     :exp_month => "2"
    #     :exp_year => "22"
    #     :cvc => "123"
    #   }
    # }
  end

  def show
  end


  def create
  end

end
