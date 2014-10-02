module Legacy
  # Lecture model
  class Lecture < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection "legacy_#{Rails.env}"
    self.table_name = "lectures"
  end

end