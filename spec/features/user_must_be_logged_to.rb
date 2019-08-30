require 'rails_helper'

feature "User must be logged to:" do
    scenario 'successfully edit a recipe' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        RecipeType.create!(name: 'Entrada')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        Cuisine.create!(cuisine_name: 'De Casa')

        user = User.create!(email: 'email@email.com', password: '123456')

        visit root_path
        click_on 'Bolodecenoura'
        click_on 'Editar'
    
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

    scenario 'and fail to edit a recipe if is not logged' do
        recipe_type = RecipeType.create!(name: 'Sobremesa')
        RecipeType.create!(name: 'Entrada')
        cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
        Cuisine.create!(cuisine_name: 'De Casa')

        user = User.create!(email: 'email@email.com', password: '123456')

        Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
            recipe_type: recipe_type, cuisine: cuisine, user: user,
            cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
            cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
        

        click_on 'Bolo de Cenoura'

        expect(page).not_to have_contant('Editar')
        #expect(current_page).to eq new_user_session_path

    end

end
