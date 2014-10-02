class SubjectSerializer < ActiveModel::Serializer
  cached
  delegate :cache_key, to: :object
  attributes :id, :name, :description, :total_courses

  def total_courses
	  object.courses.count
	end
	
end