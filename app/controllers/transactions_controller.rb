class TransactionsController < ApplicationController

  before_action :authenticate_user!

  require 'payjp'

  def new
    @item = Item.find(params[:item_id])
    @user = current_user
    credit = CreditCard.where(user_id: current_user.id).first
    if credit.blank?
      move_to_credit
    else
      Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    customer = Payjp::Customer.retrieve(credit.customer_id)
    @default_card_infomation = customer.cards.retrieve(credit.card_id)
  end
  end

  def create
    @item = Item.find(params[:item_id])
    @user = current_user
    @transaction = Transaction.create(user_id: current_user.id, item_id: transaction_params[:item_id])
    @transaction.save
    @item[:status_id] = 2
    @item.save
    credit = CreditCard.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(credit.customer_id)
    @default_card_infomation = customer.cards.retrieve(credit.card_id)
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
      amount = @item.price
      charge = Payjp::Charge.create(amount: amount,
      customer: credit.customer_id,
      currency: 'jpy',
      )
  end

  private
  def transaction_params
    params.permit(:user_id, :item_id)
  end

  def move_to_credit
    redirect_to user_new_credit_card_path(user_id: current_user.id)
  end

end
