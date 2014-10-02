module Legacy
  # Universty model
  class University < ActiveRecord::Base
    self.abstract_class = true
    self.establish_connection "legacy_#{Rails.env}"
    self.table_name = "universities"
  end

end