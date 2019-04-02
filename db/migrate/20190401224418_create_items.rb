class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :item_type, foreign_key: true
      t.references :status, foreign_key: true
      t.string :title
      t.string :registry_number
      t.references :brand, foreign_key: true
      t.string :model
      t.string :color
      t.text :description

      t.timestamps
    end
  end
end
