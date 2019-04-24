class TransactionsController < ApplicationController

  require 'payjp'

  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
  end

end
