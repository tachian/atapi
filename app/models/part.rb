class Part < ActiveRecord::Base
  belongs_to :lecture
  has_many :visits
end
