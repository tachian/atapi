class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :lecture
  belongs_to :part
end