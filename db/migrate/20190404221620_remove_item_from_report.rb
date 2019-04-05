class RemoveItemFromReport < ActiveRecord::Migration[5.2]
  def change
    remove_reference :reports, :item, foreign_key: true
  end
end
