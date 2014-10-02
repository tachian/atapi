class PartSerializer < ActiveModel::Serializer
  attributes :id, :name, :teacher, :url, :duration, :order, :is_visited

  def is_visited
  	Rails.cache.fetch('part_' + object.id.to_s + '_user_' + current_user.id.to_s + '_visit') do 
      object.visits.where(user_id: current_user.id).length > 0
    end
  end
end
