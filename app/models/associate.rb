class Associate < ActiveRecord::Base
  belongs_to :room

  validates :first_name, presence: true, length: { :maximum => 40 }
  validates :last_name, presence: true, length: { :maximum => 40 }
  validates :room_id, presence: true

end
