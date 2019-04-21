class TransactionsController < ApplicationController

  def new
    @item = Item.find(params[:id])
    @user = User.find(params[:id])
  end

  def create
  end

  private
  def item_params
    params.require.(:item)
  end

end
