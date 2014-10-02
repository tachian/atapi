json.array!(@course_subjects) do |course_subject|
  json.extract! course_subject, :id, :course_id, :subject_id
  json.url course_subject_url(course_subject, format: :json)
end
