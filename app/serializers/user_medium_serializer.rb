class UserMediumSerializer < ActiveModel::Serializer
  attributes :medium

  def medium
    MediumSerializer.new(object.medium)
  end
end
