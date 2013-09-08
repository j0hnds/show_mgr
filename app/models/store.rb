class Store < ActiveRecord::Base
  belongs_to :contact_info
  has_many :phones, :as => :phoneable
  has_many :buyers

  attr_accessible :name
end
