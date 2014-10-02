module Legacy
  # Part model
  class Part < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection "legacy_#{Rails.env}"
    self.table_name = "parts"
  end

end