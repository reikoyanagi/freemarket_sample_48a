class ItemsController < ApplicationController

  require 'payjp'

  def index
    @items = Item.includes(:user).order('created_at DESC').limit(4)
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.build
      @item.build_delivery
    else
      redirect_to user_session_path
    end
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

  def show
    @item = Item.find(params[:id])
    @user = User.find_by(id: @item.user_id)
    @items = @user.items.order('created_at DESC').limit(6).where.not(id: @item.id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
  end

  def destroy
    item = Item.find((params[:id]))
    if item.user_id == current_user.id
      item.destroy
    redirect_to root_path
    end
  end



  private

  def item_params
    # 画像を複数にするときは {item_image: []} に変更
    params.require(:item)
          .permit(:name, :user_id, :condition, :price, :detail, :status_id, :brand, :size,
                   images_attributes: [:item_id, :item_image],
                   delivery_attributes: [:postage, :shipping, :region, :shipping_date]).merge(status_id: 1, user_id: current_user.id)
  end

end
