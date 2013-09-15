# -*- ruby -*-
json.array!(@shows) do | show |
  json.id show.id
  json.name show.name
  json.start_date show.start_date
  json.end_date show.end_date
  json.next_start_date show.next_start_date
  json.next_end_date show.next_end_date
  json.coordinator_id show.coordinator_id
  json.venue_id show.venue_id
end
