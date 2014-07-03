class EventSerializer < ActiveModel::Serializer
  attributes :id, :step, :created_at, :type, :data, :sequence

  has_one :user
end
