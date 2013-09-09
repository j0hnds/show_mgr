class Show < ActiveRecord::Base
  extend Rmsc::Show
  belongs_to :coordinator
  belongs_to :venue
  has_many :attendances
  has_many :buyers, through: :attendance
  has_many :registrations
  has_many :exhibitors, through: :registration

end
