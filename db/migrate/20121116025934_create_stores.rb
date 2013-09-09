class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :address_info_id, :null => false

      t.timestamps
    end
  end
end
