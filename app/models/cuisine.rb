class Cuisine < ApplicationRecord
    validates :cuisine_name, presence: { message: 'Você deve preencher todos os campos'}
    validates :cuisine_name, uniqueness: { message: 'Tipo de cozinha já cadastrado'}

has_many :recipes
end
