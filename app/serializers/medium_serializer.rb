class MediumSerializer < ActiveModel::Serializer
  attributes :name, :plot, :media_type
  attribute :submedia, if: :is_season?

  def is_season?
    object.season?
  end

  def submedia
    object.submedia.map do |project|
      ::SubmediumSerializer.new(project).attributes
    end
  end
end
