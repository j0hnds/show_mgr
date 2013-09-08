class Coordinator < ActiveRecord::Base
  has_many :shows
  belongs_to :contact_info
  has_many :phones, :as => :phoneable

  attr_accessible :first_name, :last_name

  validates_presence_of :first_name
  validates_presence_of :last_name

  scope :sorted, order("last_name ASC, first_name ASC")

end
