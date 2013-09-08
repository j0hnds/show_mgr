class Show < ActiveRecord::Base
  belongs_to :coordinator
  belongs_to :venue
  has_many :attendances
  has_many :buyers, :through => :attendance
  has_many :registrations
  has_many :exhibitors, :through => :registration

  attr_accessible :coordinator_id, :end_date, :name, :next_end_date, :next_start_date, :start_date, :venue_id
end
