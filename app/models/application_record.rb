class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def describe
    {
      id: id,
      name: name,
      plot: plot
    }
  end
end
