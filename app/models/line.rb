class Line < ActiveRecord::Base
  belongs_to :room

  attr_accessible :line, :order, :room_id
end
