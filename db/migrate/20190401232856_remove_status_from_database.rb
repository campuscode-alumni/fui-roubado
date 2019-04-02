class RemoveStatusFromDatabase < ActiveRecord::Migration[5.2]
  def change
    remove_reference :items, :status, foreign_key: true

    drop_table :statuses
  end
end
