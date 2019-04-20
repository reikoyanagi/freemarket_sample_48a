class CreditCardsController < ApplicationController

  require "payjp"

  def index
  end

  def new
  end

  def show
  end

  def pay
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    Payjp::Token.create{
      :card => {
        :number => "1234567890123"
        :exp_month => "2"
        :exp_year => "22"
        :cvc => "123"
      }
    }
  end

  def create
  end

end
