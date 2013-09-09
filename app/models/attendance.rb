class Attendance < ActiveRecord::Base
  extend Rmsc::Attendance
  belongs_to :show
  belongs_to :buyer

end
