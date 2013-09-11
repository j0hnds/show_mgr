class Venue < ActiveRecord::Base
  has_many :shows
  belongs_to :address_info
  has_many :phones, as: :phoneable
  has_many :emails, as: :emailable

end
