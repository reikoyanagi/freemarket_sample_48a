class TransactionsController < ApplicationController

  before_action :authenticate_user!

  require 'payjp'

  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
    @user = current_user
    credit = CreditCard.where(user_id: current_user.id).first
      Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
      customer = Payjp::Customer.retrieve('cus_96980e7d41efd5207b29bde0eec9')
    @default_card_infomation = customer.cards.retrieve('car_29c1583628bbff7d080e98ca8e78')
  end

  def create
    @item = Item.find(params[:item_id])
    @user = current_user
    credit = CreditCard.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve('cus_96980e7d41efd5207b29bde0eec9')
    @default_card_infomation = customer.cards.retrieve('car_29c1583628bbff7d080e98ca8e78')
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
      amount = @item.price
      charge = Payjp::Charge.create(amount: amount,
      customer: credit.customer_id,
      currency: 'jpy',
      )
    @transaction = Transaction.new
    @transaction.save
    @item[:status_id] = 2
    @item.save
  end

end
