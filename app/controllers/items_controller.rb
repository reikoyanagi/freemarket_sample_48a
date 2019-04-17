class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @item.images.build
  end
end
