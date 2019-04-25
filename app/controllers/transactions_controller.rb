class TransactionsController < ApplicationController

  before_action :authenticate_user!

  require 'payjp'

  def new
    @item = Item.find(params[:item_id])
    @transaction = Transaction.new
    @user = current_user
    # @current_user = User.find_by(id: current.user_id)
  end

end
