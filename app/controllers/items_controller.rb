class ItemsController < ApplicationController

  def index
    @items = Item.order('id ASC').limit(4)
  end

  def new
    @item = Item.new
    @item.images.build
  end
end
