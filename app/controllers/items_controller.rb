class ItemsController < ApplicationController
  before_action :authenticate_user!

  def new
    @item = Item.new
    @item_types = ItemType.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:title, :model, :item_type_id, :brand_id,
                                 :registry_number, :color, :description,
                                 :photo)
  end
end
