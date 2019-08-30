require 'rails_helper'

feature 'Visitor can search for a recipe' do

    scenario 'Successfully' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        other_recipe_type = RecipeType.create!(name: 'Doces')
        other_cuisine = Cuisine.create!(cuisine_name: 'Caseira')
        user = User.create!(email: 'email@email.com', password: '123456')
        other_user = User.create!(email: 'email2@email.com', password: '123456')
        
        recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                                recipe_type: recipe_type, cuisine: cuisine, user: user,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        other_recipe = Recipe.create!(title: 'Bolo de Banana', difficulty: 'Médio', user: other_user,
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    

        visit root_path

        fill_in 'Search title', with: 'Bolo de cenoura'
        click_on 'Buscar'

        expect(page).to have_content('Bolo de cenoura')
        expect(page).not_to have_content('Bolo de Banana')
    
    end

    scenario 'and can search for parts of recipe name' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        other_recipe_type = RecipeType.create!(name: 'Doces')
        other_cuisine = Cuisine.create!(cuisine_name: 'Caseira')
        user = User.create!(email: 'email@email.com', password: '123456')
        other_user = User.create!(email: 'email2@email.com', password: '123456')
        
        recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                                recipe_type: recipe_type, cuisine: cuisine, user: user,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        other_recipe = Recipe.create!(title: 'Bolo de Banana', difficulty: 'Médio',
                                recipe_type: other_recipe_type, cuisine: other_cuisine, user: user,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        cook_recipe = Recipe.create!(title: 'Cook de chocolate', difficulty: 'Médio', user: other_user,
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        visit root_path

        fill_in 'Search title', with: 'Bolo'
        click_on 'Buscar'

        expect(page).to have_content('Bolo de cenoura')
        expect(page).to have_content('Bolo de Banana')
        expect(page).not_to have_content('Cook de chocolate')
    
    end

    scenario 'and can find any recipe and have a message' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        other_recipe_type = RecipeType.create!(name: 'Doces')
        other_cuisine = Cuisine.create!(cuisine_name: 'Caseira')
        user = User.create!(email: 'email@email.com', password: '123456')
        other_user = User.create!(email: 'email2@email.com', password: '123456')
        
        recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                                recipe_type: recipe_type, cuisine: cuisine, user: user,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')

        other_recipe = Recipe.create!(title: 'Bolo de Banana', difficulty: 'Médio', user: user, 
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        cook_recipe = Recipe.create!(title: 'Cook de chocolate', difficulty: 'Médio', user: other_user,
                                recipe_type: other_recipe_type, cuisine: other_cuisine,
                                cook_time: 50,
                                ingredients: 'Farinha, açucar, cenoura',
                                cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        visit root_path

        fill_in 'Search title', with: 'Biscoito'
        click_on 'Buscar'

        expect(page).not_to have_content('Bolo de cenoura')
        expect(page).not_to have_content('Bolo de Banana')
        expect(page).not_to have_content('Cook de chocolate')
    
    end


    
end

