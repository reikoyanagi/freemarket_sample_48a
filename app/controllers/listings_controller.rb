class ListingsController < ApplicationController

  def list
    @items = current_user.items.order("created_at DESC")
  end

  def in_progress
    @item = Item.find(1)
  end

  def completed
    @item = Item.find(2)
  end
end
