class Venue < ActiveRecord::Base
  has_many :shows
  belongs_to :contact_info
  has_many :phones, :as => :phoneable

  attr_accessible :address_1, :address_2, :city, :name, :postal_code, :state
end
