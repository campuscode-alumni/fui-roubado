class ItemTypesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @item_types = ItemType.all
  end

  def new
    @item_type = ItemType.new
  end

  def create
    @item_type = ItemType.new(item_type_params)
    if @item_type.save
      redirect_to item_types_path
    else
      flash[:alert] = 'Não foi possível salvar o tipo de item'
      render :new
    end
  end

  private

  def item_type_params
    params.require(:item_type).permit(:name)
  end
end
