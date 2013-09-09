class AddressInfo < ActiveRecord::Base
  has_many :coordinators
  has_many :exhibitors
  has_many :stores
  has_many :venues

end
