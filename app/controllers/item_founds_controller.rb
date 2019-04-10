class ItemFoundsController < ApplicationController
  def create
    @item_found = ItemFound.new(item_found_params)
    @item = Item.find(params[:item_id])
    @item_found.item = @item
    if @item_found.save
      redirect_to @item_found
    else
      redirect_to @item
      flash[:alert] = 'Mensagem não pode ficar em branco'
    end
  end

  def show
    @item_found = ItemFound.find(params[:id])
  end

  private

  def item_found_params
    params.require(:item_found).permit(:message, :email)
  end
end
