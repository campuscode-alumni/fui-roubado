class CreateItemFounds < ActiveRecord::Migration[5.2]
  def change
    create_table :item_founds do |t|
      t.references :item, foreign_key: true
      t.text :message
      t.string :email

      t.timestamps
    end
  end
end
