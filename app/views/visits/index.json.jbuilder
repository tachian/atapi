json.array!(@visits) do |visit|
  json.extract! visit, :id, :user_id, :course_id, :lecture_id, :part_id, :time, :status
  json.url visit_url(visit, format: :json)
end
