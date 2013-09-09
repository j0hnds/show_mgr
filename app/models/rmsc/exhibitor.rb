module Rmsc::Exhibitor

  def convert(rmsc_db, rmsc_exhibitor)
    address = create_address(rmsc_db, rmsc_exhibitor)

    Exhibitor.create!(first_name: rmsc_exhibitor['first_name'],
                      last_name: rmsc_exhibitor['last_name'],
                      address_info_id: address.id).tap do | exhibitor |
      rmsc_db.map_table_id(:exhibitors, 
                           rmsc_exhibitor['exhibitor_id'], 
                           exhibitor.id)
    end
  end

  def create_address(rmsc_db, rmsc_exhibitor)
    AddressInfo.create!(address_1: rmsc_exhibitor['address_1'],
                        address_2: rmsc_exhibitor['address_2'],
                        city: rmsc_exhibitor['city'],
                        state: rmsc_exhibitor['state'],
                        postal_code: rmsc_exhibitor['postal_code'])
  end

end
