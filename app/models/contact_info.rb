class ContactInfo < ActiveRecord::Base
  has_many :coordinators
  has_many :exhibitors
  has_many :stores
  has_many :venues

  attr_accessible :address_1, :address_2, :city, :email, :postal_code, :state
end
