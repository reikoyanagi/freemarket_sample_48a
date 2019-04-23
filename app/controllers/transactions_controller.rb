class TransactionsController < ApplicationController

  require 'payjp'

  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
  end

  def create
    @item = Item.find(params[:item_id])
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
    charge = Payjp::Charge.create(
      :amoumt => @item.price,
      :card => @item.user_id.token_id,
      :currency => 'jpy',
      )
  end

  private

end
