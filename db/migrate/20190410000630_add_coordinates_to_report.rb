class AddCoordinatesToReport < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :latitude, :float
    add_column :reports, :longitude, :float
  end
end
