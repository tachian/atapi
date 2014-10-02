class UniversitySerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object
  attributes :id, :name, :fullname, :description, :status, :total_courses

  def total_courses
	  object.courses.count
	end
	
end
