class CreateAddressInfos < ActiveRecord::Migration
  def change
    create_table :address_infos do |t|
      t.string :address_1, :limit => 60
      t.string :address_2, :limit => 60
      t.string :city, :limit => 60
      t.string :state, :limit => 2
      t.string :postal_code, :limit => 10

      t.timestamps
    end
  end
end
