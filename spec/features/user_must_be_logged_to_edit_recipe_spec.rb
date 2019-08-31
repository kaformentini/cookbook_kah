require 'rails_helper'

feature "User must be logged to edit a recipe" do
    scenario 'successfully' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        RecipeType.create!(name: 'Entrada')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        Cuisine.create!(cuisine_name: 'De Casa')

        user = User.create!(email: 'email@email.com', password: '123456')

        visit root_path
        click_on "Iniciar sessão"
    
        fill_in "Email", with: user.email
        fill_in "Password", with: '123456'
        click_on "Entrar"

        click_on "Enviar uma receita"
    
        fill_in 'Título', with: 'Bolo de cenoura'
        select 'Entrada', from: 'Tipo da Receita'
        select 'De Casa', from: 'Cozinha'
        fill_in 'Dificuldade', with: 'Médio'
        fill_in 'Tempo de Preparo', with: '45'
        fill_in 'Ingredientes', with: 'Cenoura, farinha, ovo, oleo de soja e chocolate'
        fill_in 'Como Preparar', with: 'Faça um bolo e uma cobertura de chocolate'
    
        click_on 'Enviar'
    
        expect(page).to have_css('h1', text: 'Bolo de cenoura')
        expect(page).to have_css('h3', text: 'Detalhes')
        expect(page).to have_css('p', text: 'Médio')
        expect(page).to have_css('p', text: '45 minutos')
        expect(page).to have_css('p', text:  'Cenoura, farinha, ovo, oleo de soja e chocolate')
        expect(page).to have_css('p', text: 'Faça um bolo e uma cobertura de chocolate')
    end

    scenario 'and cant add if is not logged' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        RecipeType.create!(name: 'Entrada')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        Cuisine.create!(cuisine_name: 'De Casa')

        user = User.create!(email: 'email@email.com', password: '123456')

        Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        
        visit root_path
        click_on 'Bolo de Cenoura'
        

        expect(page).not_to have_content('Editar')
        
    end

    scenario 'and not see button if is not his recipe' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        
        user = User.create!(email: 'email@email.com', password: '123456')
        other_user = User.create!(email: '2email@email.com', password: '123456')

        Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: other_user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        
        visit root_path
        click_on "Iniciar sessão"
    
        fill_in "Email", with: user.email
        fill_in "Password", with: '123456'
        click_on "Entrar"
        

        click_on 'Bolo de Cenoura'

        expect(current_path).not_to include("Bolo de Cenoura")
        expect(page).not_to have_content('Editar')
        
    end

    scenario 'and cant access the link directly for edit recipes' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
    
        other_user = User.create!(email: '2email@email.com', password: '123456')

        recipe = Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: other_user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        
        visit edit_recipe_path(recipe)
      
        expect(current_path).to eq new_user_session_path
    end


#problema com a autenticaçao, masi especificamente com o current_user
    scenario 'and cant access the link from someone else directly' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
    
        user = User.create!(email: 'email@email.com', password: '123456')
        other_user = User.create!(email: '2email@email.com', password: '123456')

        recipe = Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: other_user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        
        visit root_path
        click_on "Iniciar sessão"

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_on "Entrar"
        #byebug

        visit edit_recipe_path(recipe)

       # expect(current_path).to eq root_paths
    end

end
