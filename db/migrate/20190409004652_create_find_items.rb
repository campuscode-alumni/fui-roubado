class CreateFindItems < ActiveRecord::Migration[5.2]
  def change
    create_table :find_items do |t|

      t.timestamps
    end
  end
end
