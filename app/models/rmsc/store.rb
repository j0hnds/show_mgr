module Rmsc::Store

  def convert(rmsc_db, rmsc_store)
    address = create_address(rmsc_db, rmsc_store)
    Store.create!(name: rmsc_db.store_name(rmsc_store),
                  address_info_id: address.id).tap do | store |
      store.phones << Phone.new(phone_type: 'phone',
                                phone_number: rmsc_store['phone']) if rmsc_store['phone'].present?
      store.phones << Phone.new(phone_type: 'fax',
                                phone_number: rmsc_store['fax']) if rmsc_store['fax'].present?
      
      rmsc_db.map_table_id(:stores, rmsc_store['store_id'], store.id)
    end
  end

  def create_address(rmsc_db, rmsc_store)
    AddressInfo.create!(address_1: rmsc_store['address_1'],
                        address_2: rmsc_store['address_2'],
                        city: rmsc_store['city'],
                        state: rmsc_store['state'],
                        postal_code: rmsc_store['postal_code'])
  end


end
