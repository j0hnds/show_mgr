# This script must be run with the rails runner

shows = Show.order("start_date DESC")

prev_start_date = nil
prev_end_date = nil
shows.each do | show |
  show.update_attributes!(next_start_date: prev_start_date,
                          next_end_date: prev_end_date) if prev_start_date.present?
  prev_start_date = show.start_date
  prev_end_date = show.end_date
end

