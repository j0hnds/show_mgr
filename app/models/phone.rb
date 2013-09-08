class Phone < ActiveRecord::Base
  belongs_to :phoneable, :polymorphic => true

  attr_accessible :phone_number, :phone_type
end
