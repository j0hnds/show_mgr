module Rmsc::Buyer

  def convert(rmsc_db, rmsc_buyer)
    store_id = rmsc_db.table_id(:stores, rmsc_buyer['store_id'])

    Buyer.create!(store_id: store_id,
                  first_name: rmsc_buyer['first_name'],
                  last_name: rmsc_buyer['last_name']).tap do | buyer |
      buyer.phones << Phone.new(phone_type: 'cell',
                                phone_number: rmsc_buyer['cell']) if rmsc_buyer['cell'].present?
      buyer.emails << Email.new(email_type: 'email',
                                address: rmsc_buyer['email']) if rmsc_buyer['email'].present?
      rmsc_db.map_table_id(:buyers, rmsc_buyer['buyer_id'], buyer.id)
    end
  end

end
