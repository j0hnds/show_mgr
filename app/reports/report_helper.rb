module ReportHelper

  def exhibitor_rooms(rooms)
    room_label = "Room"
    room_label = room_label.pluralize if rooms.count > 1

    "#{room_label}: #{rooms.join(', ')}"
  end


end
