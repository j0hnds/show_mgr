class Attendance < ActiveRecord::Base
  belongs_to :show
  belongs_to :buyer

  attr_accessible :buyer_id, :show_id
end
