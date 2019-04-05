class RemoveAdressFromReport < ActiveRecord::Migration[5.2]
  def change
    remove_column :reports, :adress, :string
  end
end
