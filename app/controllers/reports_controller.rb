class ReportsController < ApplicationController

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      redirect_to @report
    else
      flash[:alert] = 'Não foi possível criar o relatório'
      render :new
    end
  end

  def show
    @report = Report.find(params[:id])
    @report_items = @report.items
  end

  private

  def report_params
    params.require(:report).permit(:address, :ocurrance_date, :description, :police_report, item_ids:[])
  end
end