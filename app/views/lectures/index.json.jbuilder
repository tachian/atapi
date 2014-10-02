json.array!(@lectures) do |lecture|
  json.extract! lecture, :id, :course_id, :name, :subtitle, :avatar, :order
  json.url lecture_url(lecture, format: :json)
end
