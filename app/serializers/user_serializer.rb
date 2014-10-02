class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :birthday, :email, :fb_id, :avatar, :sign_in_count, :authentication_token, :created_at, :remember_created_at
end
