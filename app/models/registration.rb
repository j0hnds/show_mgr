class Registration < ActiveRecord::Base
  extend Rmsc::Registration
  belongs_to :show
  belongs_to :exhibitor
  has_many :rooms

end
