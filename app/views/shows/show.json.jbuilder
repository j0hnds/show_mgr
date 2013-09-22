# -*- ruby -*-
json.id @show.id
json.name @show.name
json.start_date @show.start_date
json.end_date @show.end_date
json.next_start_date @show.next_start_date
json.next_end_date @show.next_end_date
json.coordinator_id @show.coordinator_id
json.venue_id @show.venue_id
json.coordinator do
  json.id @show.coordinator.id
  json.first_name @show.coordinator.first_name
  json.last_name @show.coordinator.last_name
  json.phones do
    json.array!(@show.coordinator.phones) do | phone |
      json.id phone.id
      json.phone_type phone.phone_type
      json.phone_number phone.phone_number
    end
  end
  json.emails do
    json.array!(@show.coordinator.emails) do | email |
      json.id email.id
      json.email_type email.email_type
      json.address email.address
    end
  end
end
json.venue do
  json.id @show.venue.id
  json.name @show.venue.name
  json.address_info_id @show.venue.address_info.id
  json.address_1 @show.venue.address_info.address_1
  json.address_2 @show.venue.address_info.address_2
  json.city @show.venue.address_info.city
  json.state @show.venue.address_info.state
  json.postal_code @show.venue.address_info.postal_code
  json.phones do
    json.array!(@show.venue.phones) do | phone |
      json.id phone.id
      json.phone_type phone.phone_type
      json.phone_number phone.phone_number
    end
  end
  json.emails do
    json.array!(@show.venue.emails) do | email |
      json.id email.id
      json.email_type email.email_type
      json.address email.address
    end
  end
end
