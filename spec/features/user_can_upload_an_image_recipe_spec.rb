require 'rails_helper'

feature "User can upload an image to the recipe" do
    scenario "successfully" do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        
        visit root_path
        click_on 'Cadastrar Receita'

        fill_in 'Título', with: 'Tabule'
        select 'Sobremesa', from: 'Tipo da Receita'
        select 'Brasileira', from: 'Cozinha'
        attach_file("Imagem", Rails.root + '/home/kah/Área de Trabalho/índice.jpeg') 

        fill_in 'Dificuldade', with: 'Fácil'
        fill_in 'Tempo de Preparo', with: '45'
        fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
        fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
        
        click_on 'Enviar'

        ####expect(page).to have_content('índice.jpeg')
    end

    scenario "and see the image in the root_path resume" do

        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        
        visit root_path
        
        ####expect(page).to have_content('índice.jpeg')

    end
    
end
