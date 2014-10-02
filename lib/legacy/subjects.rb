module Legacy
  # Subject model
  class Subject < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection "legacy_#{Rails.env}"
    self.table_name = "course_lists"
  end

end