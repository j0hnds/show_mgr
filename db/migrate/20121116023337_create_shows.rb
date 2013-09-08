class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name, :limit => 40
      t.date :start_date
      t.date :end_date
      t.date :next_start_date
      t.date :next_end_date
      t.integer :coordinator_id, :null => false
      t.integer :venue_id, :null => false

      t.timestamps
    end
  end
end
