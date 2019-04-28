class ItemsController < ApplicationController

  require 'payjp'

  def index
    @items = Item.order('created_at DESC').limit(4)
  end

  def new
    @item = Item.new
    @item.images.build
    @item.build_delivery
  end

  def create
    # 画像以外のファイルを格納
    @item = Item.new(item_params)

    if image_judge != 0
      if @item.save &&
        # 画像ファイルは @item.id が必要なので @itemが保存された後に引っ張る
        @image = Image.save_image(image_params[:images_attributes],@item.id)
        respond_to do |format|
          format.html { redirect_to :root }
          format.json
        end
      else
        render :new
      end
    else
      render :new
    end

  end

  def show
    @item = Item.find(params[:id])
    @user = User.find_by(id: @item.user_id)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find((params[:id]))
    if item.user_id== current_user.id
      item.destroy
    redirect_to root_path
    end

  end

  def update
    @item = Item.find(params[:id])
    @item[:status_id] = 2
    @item.save
    Payjp.api_key = 'sk_test_0ed9e660871befcb2421e447'
      amount = @item.price
      charge = Payjp::Charge.create(amount: amount,
      card: params['payjp-token'],
      currency: 'jpy',
      )
  end

  private

  def item_params
    # 画像を複数にするときは {item_image: []} に変更
    params.require(:item)
          .permit(:name, :user_id, :condition, :price, :detail, :status_id, :brand, :size,
                   delivery_attributes: [:postage, :shipping, :region, :shipping_date]).merge(status_id: 1, user_id: current_user.id)
  end

  def image_params
    params.require(:item).permit(images_attributes: [:item_id, {item_image: []}])
  end

  def image_judge
    params.require(:item).require(:images_attributes).require(:'0').require(:item_image).length
  end


end
