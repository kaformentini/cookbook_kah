class Cuisine < ApplicationRecord
    validates :cuisine_name, presence: {message: 'Você deve preencher o campo TIPO'}
    validates :cuisine_name, uniqueness: { message: 'Tipo de cozinha já cadastrado'}

has_many :recipes
end
