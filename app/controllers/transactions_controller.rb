class TransactionsController < ApplicationController

  require 'payjp'

  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
    @user = User.find_by(id: @item.user_id)
  end

end
