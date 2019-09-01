require 'rails_helper'

describe 'request information of recipe from recipes type' do


    it 'successfully return json' do 
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        other_recipe_type = RecipeType.create!(name: 'Entrada')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
               
        user = User.create!(email: 'email@email.com', password: '123456')

        recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio', user: user,
                                recipe_type: recipe_type, cuisine: cuisine,
                                cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        other_recipe = Recipe.create!(title: 'Bolo de banana', difficulty: 'Médio', user: user,
                                    recipe_type: other_recipe_type, cuisine: cuisine,
                                    cook_time: 50, ingredients: 'Farinha, açucar, banana',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        another_recipe = Recipe.create!(title: 'Bolo de morango', difficulty: 'Médio', user: user,
                                    recipe_type: recipe_type, cuisine: cuisine,
                                    cook_time: 50, ingredients: 'Farinha, açucar, banana',
                                    cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        get "/api/v1/recipe_types/#{recipe_type.id}"
        
        
        expect(response.status).to eq 200
        #expect(response.body).to include('Sobremesa')
        expect(response.body).to include('Bolo de cenoura')
        expect(response.body).to include('Bolo de morango')
        expect(response.body).not_to include('Bolo de banana')




    end

end
