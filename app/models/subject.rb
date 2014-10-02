class Subject < ActiveRecord::Base
	# has_many :courses, through: :course_subjects
 #  has_many :course_subjects

  has_and_belongs_to_many :courses
end
