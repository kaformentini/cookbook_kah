require 'rails_helper'

feature 'Visitor can search for a recipe' do

    scenario 'Successfully' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        other_recipe_type = RecipeType.create!(name: 'Doces')
        other_cuisine = Cuisine.create!(cuisine_name: 'Caseira')
        
        recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                                recipe_type: recipe_type, cuisine: cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        other_recipe = Recipe.create!(title: 'Bolo de Banana', difficulty: 'Médio',
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    

        visit root_path

        fill_in 'Buscar por', with: 'Bolo de cenoura'
        click_on 'Buscar'

        expect(page).to have_content('Bolo de cenoura')
        expect(page).not_to have_content('Bolo de Banana')
    
    end

    scenario 'Successfully' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        other_recipe_type = RecipeType.create!(name: 'Doces')
        other_cuisine = Cuisine.create!(cuisine_name: 'Caseira')
        
        recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                                recipe_type: recipe_type, cuisine: cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        other_recipe = Recipe.create!(title: 'Bolo de Banana', difficulty: 'Médio',
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        cook_recipe = Recipe.create!(title: 'Cook de chocolate', difficulty: 'Médio',
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        visit root_path

        fill_in 'Buscar por', with: 'Bolo'
        click_on 'Buscar'

        expect(page).to have_content('Bolo de cenoura')
        expect(page).to have_content('Bolo de Banana')
        expect(page).not_to have_content('Cook de chocolate')
    
    end

end

