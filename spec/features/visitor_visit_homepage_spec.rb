require 'rails_helper'

feature 'Visitor visit homepage' do
  scenario 'successfully' do
    visit root_path

    expect(page).to have_content('CookBook')
    expect(page).to have_css('p', text: 'Bem-vindo ao maior livro de receitas online')
  end

  scenario 'and view recipe' do
    #cria os dados necessários
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
    user = User.create!(email: 'email@email.com', password: '123456')
    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio', user: user,
                           recipe_type: recipe_type, cuisine: cuisine,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    

    # simula a ação do usuário
    visit root_path

    # expectativas do usuário após a ação
    expect(page).to have_content(recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.cuisine_name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")
  end

  scenario 'and view recipes list' do
    #cria os dados necessários
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    another_recipe_type = RecipeType.create!(name: 'Prato principal')
    cuisine = Cuisine.create!(cuisine_name: 'Brasileira')
    user = User.create!(email: 'email@email.com', password: '123456')

    recipe = Recipe.create!(title: 'Bolo de cenoura', difficulty: 'Médio',
                           recipe_type: recipe_type, cuisine: cuisine, user: user,
                           cook_time: 50,
                           ingredients: 'Farinha, açucar, cenoura',
                           cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')
    
    another_recipe = Recipe.create!(title: 'Feijoada',
                                   recipe_type: another_recipe_type, user: user, 
                                   cuisine: cuisine, difficulty: 'Difícil',
                                   cook_time: 90,
                                   ingredients: 'Feijão e carnes',
                                   cook_method: 'Misture o feijão com as carnes')

    # simula a ação do usuário
    visit root_path
    

    # expectativas do usuário após a ação
    expect(page).to have_content(recipe.title)
    expect(page).to have_css('li', text: recipe.recipe_type.name)
    expect(page).to have_css('li', text: recipe.cuisine.cuisine_name)
    expect(page).to have_css('li', text: recipe.difficulty)
    expect(page).to have_css('li', text: "#{recipe.cook_time} minutos")

    expect(page).to have_content( another_recipe.title)
    expect(page).to have_css('li', text: another_recipe.recipe_type.name)
    expect(page).to have_css('li', text: another_recipe.cuisine.cuisine_name)
    expect(page).to have_css('li', text: another_recipe.difficulty)
    expect(page).to have_css('li', text: "#{another_recipe.cook_time} minutos")
  end
end
