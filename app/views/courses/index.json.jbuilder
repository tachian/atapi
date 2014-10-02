json.array!(@courses) do |course|
  json.extract! course, :id, :university_id, :avatar, :name, :description, :status
  json.url course_url(course, format: :json)
end
