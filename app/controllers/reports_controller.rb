class ReportsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create show]

  def index
    @reports = Report.where(user: current_user)

    return if @reports.any?

    flash[:alert] = 'Não há relatórios cadastrados'
  end

  def new
    @report = Report.new
    @items = Item.where(user: current_user, status: :owned)
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    if @report.save
      @items = @report.items 
      @items.each do |item|
        item.update(status: :stolen)
      end 
      redirect_to @report
    else
      flash[:alert] = 'Não foi possível criar o relatório'
      @items = Item.where(user: current_user, status: :owned)
      render :new
    end
  end

  def show
    @report = Report.find(params[:id])
    @report_items = @report.items
  end

  private

  def report_params
    params.require(:report).permit(:address, :ocurrance_date,
                                   :description, :police_report, item_ids: [])
  end
end
