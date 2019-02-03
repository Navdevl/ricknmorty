class UserMediumSerializer < ActiveModel::Serializer
  attribute :time_remaining
  belongs_to :medium
  belongs_to :user

  def time_remaining
    object.expires_at - Time.now
  end
end
