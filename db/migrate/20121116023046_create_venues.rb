class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name, :limit => 40
      t.integer :contact_info_id, :null => false

      t.timestamps
    end
  end
end
