require 'rails_helper'

feature "User can upload an image to the recipe" do
    scenario "successfully" do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        user = User.create!(email: 'email@email.com', password: '123456')
        
        visit root_path
        click_on "Iniciar sessão"

        fill_in "Email", with: user.email
        fill_in "Password", with: '123456'
        click_on "Entrar"


        click_on 'Enviar uma receita'

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
        user = User.create!(email: 'email@email.com', password: '123456')
        
        Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        
        visit root_path
        
        ####expect(page).to have_content('índice.jpeg')

    end

    
    scenario "and can upload more than one image" do

        recipe_type = RecipeType.create!(name: 'Sobremesa')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        user = User.create!(email: 'email@email.com', password: '123456')
        
        Recipe.create!(title: 'Bolodecenoura', difficulty: 'Médio',
                        recipe_type: recipe_type, cuisine: cuisine, user: user,
                        cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                        cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
        

        visit root_path
        click_on "Iniciar sessão"

        fill_in "Email", with: user.email
        fill_in "Password", with: '123456'
        click_on "Entrar"
        
        click_on 'Enviar uma receita'

        fill_in 'Título', with: 'Tabule'
        select 'Sobremesa', from: 'Tipo da Receita'
        select 'Brasileira', from: 'Cozinha'
        attach_file("Imagem", [Rails.root + '/home/kah/Área de Trabalho/índice.jpeg', Rails.root + '/home/kah/Área de Trabalho/bolodecenoura.jpeg']) 

        fill_in 'Dificuldade', with: 'Fácil'
        fill_in 'Tempo de Preparo', with: '45'
        fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
        fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
        
        click_on 'Enviar'
        
        ####expect(page).to have_content('índice.jpeg')

    end
    
end
