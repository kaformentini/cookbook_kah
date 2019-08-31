require 'rails_helper'

describe 'request information for recipes type' do


    it 'successfully return json' do 
        recipe_type = RecipeType.create!(name: 'Sobremesa')
               
        get "/api/v1/recipe_type/#{recipe_type.id}"

        json_recipe_type = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 200
        expect(json_recipe[:name]).to eq recipe_type.name
    end

    it 'fail to get a recipe type' do
       
        get "/api/v1/recipe_types/000"

        json_recipe_type = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 404
        expect(response.body).to include('Tipo de receita não encontrada')

    end

    it 'successfully make a post of new recipe_type' do 
       
       
        post "/api/v1/recipe_types", params: {recipe_type: { name: 'Brasileira'}}

        json_recipe_type = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 201
        expect(json_recipe_type[:name]).to include('Brasileira')
    end

    it 'fail to post a recipe type' do
       
        post "/api/v1/recipe_types", params: {recipe_type: { name: ''}}

        json_recipe = JSON.parse(response.body, symbolize_names: true)

        expect(response.status).to eq 412
        expect(response.body).to include("Falha ao registrar uma receita")

    end

    

end

