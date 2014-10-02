class VisitSerializer < ActiveModel::Serializer
	cached
  delegate :cache_key, to: :object
  attributes :course_id, :course_name, :teacher, :university_name, :total_parts

  def course_id
  	object.course.id
  end
  
  def course_name
  	object.course.name
  end

  def teacher
  	object.course.parts.first.teacher
  end

  def university_name
  	object.course.university.name
  end

  def total_parts
  	object.course.parts.count
  end
end