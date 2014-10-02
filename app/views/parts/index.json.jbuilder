json.array!(@parts) do |part|
  json.extract! part, :id, :lecture_id, :name, :teacher, :url, :duration, :order
  json.url part_url(part, format: :json)
end
