class TransactionsController < ApplicationController

  def new
    @item = Item.find(1)
  end

  def create
  end

  private

end
