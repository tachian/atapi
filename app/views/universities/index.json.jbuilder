json.array!(@universities) do |university|
  json.extract! university, :id, :name, :fullname, :description, :status
  json.url university_url(university, format: :json)
end
