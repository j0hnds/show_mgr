class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :room_id, :null => false
      t.integer :order, :null => false
      t.string :line, :null => false, :limit => 80

      t.timestamps
    end
  end
end
