class PurchaseSerializer < ActiveModel::Serializer
  belongs_to :user
  belongs_to :medium
end
