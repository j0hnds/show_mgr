class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :show_id, :null => false
      t.integer :exhibitor_id, :null => false

      t.timestamps
    end
  end
end
