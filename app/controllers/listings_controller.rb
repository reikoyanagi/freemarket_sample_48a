class ListingsController < ApplicationController

  def list
    @items = Item.order('created_at DESC').limit(4)
  end

  def in_progress
    @item = Item.find(1)
  end

  def completed
    @item = Item.find(2)
  end

end
