class Buyer < ActiveRecord::Base
  extend Rmsc::Buyer
  belongs_to :store
  has_many :phones, as: :phoneable
  has_many :emails, as: :emailable

end
