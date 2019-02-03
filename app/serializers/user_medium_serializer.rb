class UserMediumSerializer < ActiveModel::Serializer
  attributes :purchased_at, :expires_in
  belongs_to :medium
  belongs_to :user

  def expires_in
    object.expires_in
  end
end
