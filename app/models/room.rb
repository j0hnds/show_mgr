class Room < ActiveRecord::Base
  belongs_to :registration
  has_many :associates
  has_many :lines

end
