class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :latest, -> {order(created_at: :desc)}

  def describe
    {
      id: id,
      name: name,
      plot: plot,
      created_at: created_at
    }
  end
end
