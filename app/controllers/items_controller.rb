class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
    @item.images.build
    @item.build_delivery
  end

  def create
    Item.create(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :user_id, :text, :price, :detail, :status_id, :brand, :size, images_attributes: [:item_id, :item_image], delivery: [:postage, :shipping, :region, :shipping_date])
  end
end
