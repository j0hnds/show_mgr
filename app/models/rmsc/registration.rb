module Rmsc::Registration

  def convert(rmsc_db, rmsc_exhibitor_attendance)
    Registration.create!(show_id: rmsc_db.table_id(:shows, rmsc_exhibitor_attendance['show_id']),
                         exhibitor_id: rmsc_db.table_id(:exhibitors, rmsc_exhibitor_attendance['exhibitor_id'])).tap do | registration |
      Room.create!(registration_id: registration.id,
                   room: rmsc_exhibitor_attendance['room_assignment']).tap do | room |
        rmsc_db.attendee_lines(rmsc_exhibitor_attendance['show_id'],
                               1,
                               rmsc_exhibitor_attendance['exhibitor_id']) do | line |
          Line.create!(room_id: room.id,
                       order: line['priority'],
                       line: line['line'])
        end

        rmsc_db.exhibitor_associates(rmsc_exhibitor_attendance['show_id'],
                                     rmsc_exhibitor_attendance['exhibitor_id']) do | associate |
          Associate.create!(room_id: room.id,
                            first_name: associate['first_name'],
                            last_name: associate['last_name'])
        end
      end
    end
  end

end
