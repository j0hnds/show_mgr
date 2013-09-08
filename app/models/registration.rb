class Registration < ActiveRecord::Base
  belongs_to :show
  belongs_to :exhibitor
  has_many :rooms

  attr_accessible :exhibitor_id, :show_id
end
