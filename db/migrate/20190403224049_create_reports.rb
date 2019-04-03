class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :item, foreign_key: true
      t.string :description
      t.datetime :ocurrance_date
      t.string :adress

      t.timestamps
    end
  end
end
