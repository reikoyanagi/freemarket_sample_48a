class TransactionsController < ApplicationController

  def new
    @item = Item.find(params[:id])
  end

  def create
  end

  private

end
