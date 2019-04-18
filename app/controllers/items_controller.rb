class ItemsController < ApplicationController

  def index
    @items = Item.order('id ASC').limit(4)
  end

  def new
    # 出品機能
    @item = Item.new
    @item.images.build
    @item.build_delivery
  end

  def create
    # 出品機能
    Item.create(item_params)
  end

  private

  def item_params
    # 出品機能
    params.require(:item).permit(:name, :user_id, :condition, :price, :detail, :status_id, :brand, :size, images_attributes: [:item_id, :item_image], delivery_attributes: [:postage, :shipping, :region, :shipping_date])
  end
end
