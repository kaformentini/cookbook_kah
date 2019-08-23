class RecipeType < ApplicationRecord
    validates :name, presence: {message: 'Você deve preencher o campo TIPO'}
    validates :name, uniqueness: { message: 'Tipo de receita já cadastrado'}
has_many :recipes
end
