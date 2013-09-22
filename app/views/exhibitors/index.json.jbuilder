# -*- ruby -*-
json.array!(@exhibitors) do | exhibitor |
  json.id = exhibitor.id
  json.first_name exhibitor.first_name
  json.last_name exhibitor.last_name
  address = exhibitor.address_info
  json.address_info_id address.id
  json.address_1 address.address_1
  json.address_2 address.address_2
  json.city address.city
  json.state address.state
  json.postal_code address.postal_code
  json.phones do
    json.array!(exhibitor.phones) do | phone |
      json.id phone.id
      json.phone_type phone.phone_type
      json.phone_number phone.phone_number
    end
  end
  json.emails do
    json.array!(exhibitor.emails) do | email |
      json.id = email.id
      json.email_type email.email_type
      json.address email.address
    end
  end
end
