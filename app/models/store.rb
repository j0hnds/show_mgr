class Store < ActiveRecord::Base
  extend Rmsc::Store
  belongs_to :contact_info
  belongs_to :address_info
  has_many :phones, as: :phoneable
  has_many :emails, as: :emailable
  has_many :buyers

end
