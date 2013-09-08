class Exhibitor < ActiveRecord::Base
  belongs_to :contact_info
  has_many :phones, :as => :phoneable

  attr_accessible :first_name, :last_name
end
