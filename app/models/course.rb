class Course < ActiveRecord::Base
  belongs_to :university
  has_many :lectures
  has_many :parts, through: :lectures

  # has_many :subjects, through: :course_subjects
  # has_many :course_subjects

  has_and_belongs_to_many :subjects

  has_many :visits
end
