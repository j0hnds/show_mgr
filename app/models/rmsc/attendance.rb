module Rmsc::Attendance

  def convert(rmsc_db, rmsc_buyer)
    Attendance.create!(show_id: rmsc_db.table_id(:shows, rmsc_buyer['show_id']),
                       buyer_id: rmsc_db.table_id(:buyers, rmsc_buyer['buyer_id']))
  end

end
