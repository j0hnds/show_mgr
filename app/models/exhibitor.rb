class Exhibitor < ActiveRecord::Base
  extend Rmsc::Exhibitor
  belongs_to :address_info
  has_many :phones, as: :phoneable
  has_many :emails, as: :emailable

end
