class RecipeType < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: {massage: 'Tipo de receita já cadastrado'}
has_many :recipes
end
