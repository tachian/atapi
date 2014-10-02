json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :birthday, :gender, :avatar, :fb_id, :fb_at, :origin, :provider, :status
  json.url user_url(user, format: :json)
end
