module Rmsc::Show

  def convert(rmsc_db, rmsc_show)
    # Do we need to create the coordinator and venue stuff?
    create_coordinator(rmsc_db, rmsc_show) unless rmsc_db.table_has_keys?(:coordinators)
    create_venue(rmsc_db, rmsc_show) unless rmsc_db.table_has_keys?(:venues)

    Show.create!(name: rmsc_show['description'],
                 start_date: rmsc_show['start_date'],
                 end_date: rmsc_show['end_date'],
                 coordinator_id: rmsc_db.table_ids(:coordinators).values.first,
                 venue_id: rmsc_db.table_ids(:venues).values.first).tap do | show |
      rmsc_db.map_table_id(:shows, rmsc_show['show_id'], show.id)
    end
  end

  def create_coordinator(rmsc_db, rmsc_show)
    name_list = rmsc_show['coordinator'].split(' ')
    Coordinator.create!(first_name: name_list.first,
                        last_name: name_list.last).tap do | coordinator |
      coordinator.phones << Phone.new(phone_type: 'phone',
                                      phone_number: rmsc_show['coordinator_phone'])
      coordinator.emails << Email.new(email_type: 'email',
                                      address: rmsc_show['coordinator_email'])
      rmsc_db.map_table_id(:coordinators, rmsc_show['show_id'], coordinator.id)
    end
  end

  def create_venue(rmsc_db, rmsc_show)
    address = AddressInfo.create!(address_1: rmsc_show['location_address'],
                                  city: rmsc_show['location_city'],
                                  state: rmsc_show['location_state'],
                                  postal_code: rmsc_show['location_postal_code'])

    Venue.create!(name: rmsc_show['location'],
                          address_info_id: address.id).tap do | venue |
    
      venue.phones << Phone.new(phone_type: 'phone',
                                phone_number: rmsc_show['location_phone']) if rmsc_show['location_phone'].present?
      venue.phones << Phone.new(phone_type: 'fax',
                                phone_number: rmsc_show['location_fax']) if rmsc_show['location_fax'].present?
      venue.phones << Phone.new(phone_type: 'reservation',
                                phone_number: rmsc_show['location_reservation']) if rmsc_show['location_reservation'].present?
      rmsc_db.map_table_id(:venues, rmsc_show['show_id'], venue.id)
    end
  end

end
