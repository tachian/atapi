module Legacy
  # Course model
  class Course < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection "legacy_#{Rails.env}"
    self.table_name = "courses"
  end

end