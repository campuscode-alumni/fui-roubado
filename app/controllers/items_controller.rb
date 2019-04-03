class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show]

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

  def search
    @search_results = Item.where(registry_number: params[:q],
                                 item_type_id: params[:item_type_id])
                          .where.not(status: :owned).limit(1).first

    return if @search_results.present?

    flash[:alert] = 'O item procurado não está registrado como'\
                    ' roubado ou furtado.'
  end

  private

  def item_params
    params.require(:item).permit(:title, :model, :item_type_id, :brand_id,
                                 :registry_number, :color, :description,
                                 :photo)
  end
end
