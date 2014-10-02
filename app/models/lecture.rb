class Lecture < ActiveRecord::Base
  belongs_to :course
  has_many :parts
  has_many :visits
end
