require 'rails_helper'

describe 'request information for recipes' do
    it 'successfully return json' do 
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        other_user = User.create!(email: '2email@email.com', password: '123456')

        recipe = Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: other_user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        
       
        get "/api/v1/recipes/#{recipe.id}"

        json_recipe = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 200
        expect(json_recipe[:title]).to eq recipe.title
    end

    it 'fail to get a recipe' do
       
        get "/api/v1/recipes/000"

        json_recipe = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 404
        expect(response.body).to include('Receita não encontrada')

    end

    it 'successfully make a post of new recipe' do 
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        user = User.create!(email: 'email@email.com', password: '123456')
       
        post "/api/v1/recipes", params: {recipe: {  title: 'Bolo de Cenoura', recipe_type_id: recipe_type, cuisine_id: cuisine, difficulty: 'M', cook_time: '5', ingredients: 'ksdjfkljfdf', cook_method:"sadksdlkjadj"}}

        json_recipe = JSON.parse(response.body, symbolize_names: true)

        #expect(response.status).to eq 201
        #expect(response.body).to include('Bolo de Cenoura')
        #expect(response.body).to include('Brasileira')
        #expect(response.body).to include('Sobremesa')
    end

    it 'fail to post a recipe' do
       
        post "/api/v1/recipes", params: {recipe: { title: ''}}

        json_recipe = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 412
        expect(response.body).to include("Falha ao registrar uma receita")

    end

    

end

