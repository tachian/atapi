class LectureSerializer < ActiveModel::Serializer
	cached
  delegate :cache_key, to: :object
  attributes :id, :name, :subtitle, :avatar, :order, :course, :parts
end
