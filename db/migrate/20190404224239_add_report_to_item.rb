class AddReportToItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :report, foreign_key: true
  end
end
