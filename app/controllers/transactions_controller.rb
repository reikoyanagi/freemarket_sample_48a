class TransactionsController < ApplicationController

  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
  end

  def create
  end

  private

end
