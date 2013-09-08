class Buyer < ActiveRecord::Base
  belongs_to :contact_info
  belongs_to :store
  has_many :phones, :as => :phoneable

  attr_accessible :contact_info_id, :first_name, :last_name, :store_id
end
