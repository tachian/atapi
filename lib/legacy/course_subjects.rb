module Legacy
  # CourseSubject model
  class CourseSubject < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection "legacy_#{Rails.env}"
    self.table_name = "course_course_lists"
  end

end