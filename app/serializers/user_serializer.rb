class UserSerializer < ActiveModel::Serializer
  attributes :id, 
  					 :name, 
  					 :gender, 
  					 :birthday, 
  					 :email, 
  					 :fb_id, 
  					 :avatar, 
  					 :sign_in_count, 
  					 :authentication_token, 
  					 :created_at, 
  					 :remember_created_at,
  					 :is_visited_courses,
  					 :is_new

  def is_visited_courses
  	object.visits.count > 0
  end

  def is_new
  	!is_visited_courses
  end
end



