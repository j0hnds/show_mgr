class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :first_name, :limit => 40
      t.string :last_name, :limit => 40
      t.integer :contact_info_id, :null => false
      t.integer :store_id, :null => false

      t.timestamps
    end
  end
end
