class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create show my]

  def new
    @item = Item.new
    @item_types = ItemType.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to @item
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def my
    @items = Item.where(user: current_user)

    return if @items.any?

    flash[:alert] = 'Não há itens cadastrados'
  end

  def destroy
    @item = Item.find(params[:id])
    if @item.user == current_user
      @item.destroy
      flash[:notice] = 'Item excluido com sucesso'
      redirect_to my_items_path
    else
      redirect_to root_path, status: :forbidden
    end
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
