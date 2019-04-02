class AddStatusToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :status, :integer, null: 0, default: 0
  end
end
