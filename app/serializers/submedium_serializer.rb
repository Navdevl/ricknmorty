class SubmediumSerializer < ActiveModel::Serializer
  attributes :name, :plot
  attribute :sub_id, key: :episode_index

end
