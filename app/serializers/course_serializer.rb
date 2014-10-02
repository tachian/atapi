class CourseSerializer < ActiveModel::Serializer
	cached
  delegate :cache_key, to: :object
  attributes :id, :avatar, :name, :description, :status, :university, :teacher, :totalLectures, :totalParts, :lectures

  def totalLectures
	  object.lectures.count
	end

	def totalParts
		object.parts.count
	end

	def teacher
		object.parts.first.teacher
	end

end
