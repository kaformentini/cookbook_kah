class Recipe < ApplicationRecord
  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time, :difficulty, :ingredients, :cook_method, presence: true

  belongs_to :recipe_type
  belongs_to :cuisine

  def cook_time_min
    "#{cook_time} minutos"

  end

end
