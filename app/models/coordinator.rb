class Coordinator < ActiveRecord::Base
  has_many :shows
  has_many :phones, as: :phoneable
  has_many :emails, as: :emailable

  validates_presence_of :first_name
  validates_presence_of :last_name

  scope :sorted, order("last_name ASC, first_name ASC")

end
