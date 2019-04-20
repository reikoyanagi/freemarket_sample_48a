class ItemsController < ApplicationController

  def index
    @items = Item.order('id ASC').limit(4)
  end

  def new
    @item = Item.new
    @item.images.build
    @item.build_delivery
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      respond_to do |format|
        format.html { redirect_to :root }
        format.json
      end
    else
      render :new
    end

  end

  private

  def item_params
    params.require(:item)
          .permit(:name, :user_id, :condition, :price, :detail, :status_id, :brand, :size,
                   images_attributes: [:item_id, :item_image],
                   delivery_attributes: [:postage, :shipping, :region, :shipping_date]).merge(status_id: 1)
  end
end
