require 'rails_helper'

feature 'User register recipe' do
  scenario 'successfully' do
    #cria os dados necessários, nesse caso não vamos criar dados no banco
    RecipeType.create(name: 'Sobremesa')
    RecipeType.create(name: 'Entrada')
    Cuisine.create(cuisine_name: 'Brasileira')
    Cuisine.create(cuisine_name: 'Arabe')

    user = User.create!(email: 'email@email.com', password: '123456')

        visit root_path
        click_on "Iniciar sessão"
        
            fill_in "Email", with: user.email
            fill_in "Password", with: '123456'
            click_on "Entrar"

    # simula a ação do usuário
    #visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: 'Tabule'
    select 'Entrada', from: 'Tipo da Receita'
    select 'Arabe', from: 'Cozinha'
    fill_in 'Dificuldade', with: 'Fácil'
    fill_in 'Tempo de Preparo', with: '45'
    fill_in 'Ingredientes', with: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha'
    fill_in 'Como Preparar', with: 'Misturar tudo e servir. Adicione limão a gosto.'
    click_on 'Enviar'


    # expectativas
    expect(page).to have_css('h1', text: 'Tabule')
    expect(page).to have_css('h3', text: 'Detalhes')
    expect(page).to have_css('p', text: 'Entrada')
    expect(page).to have_css('p', text: 'Arabe')
    expect(page).to have_css('p', text: 'Fácil')
    expect(page).to have_css('p', text: "45 minutos")
    expect(page).to have_css('h3', text: 'Ingredientes')
    expect(page).to have_css('p', text: 'Trigo para quibe, cebola, tomate picado, azeite, salsinha')
    expect(page).to have_css('h3', text: 'Como Preparar')
    expect(page).to have_css('p', text:  'Misturar tudo e servir. Adicione limão a gosto.')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'email@email.com', password: '123456')
    
    # simula a ação do usuário
    visit root_path
    click_on "Iniciar sessão"
    
        fill_in "Email", with: user.email
        fill_in "Password", with: '123456'
        click_on "Entrar"

    visit root_path
    click_on 'Enviar uma receita'

    fill_in 'Título', with: ''
    fill_in 'Dificuldade', with: ''
    fill_in 'Tempo de Preparo', with: ''
    fill_in 'Ingredientes', with: ''
    fill_in 'Como Preparar', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve informar todos os dados da receita')
  end

  scenario 'and recipe need to belongs to a user' do
    recipe_type = RecipeType.create(name: 'Sobremesa')
    cuisine = Cuisine.create(cuisine_name: 'Brasileira')

    user = User.create!(email: 'email@email.com', password: '123456')

    Recipe.create!(title: 'Bolo de Cenoura', difficulty: 'Médio',
                  recipe_type: recipe_type, cuisine: cuisine, user: user,
                  cook_time: 50, ingredients: 'Farinha, açucar, cenoura',
                  cook_method: 'Cozinhe a cenoura, corte em pedaços pequenos, misture com o restante dos ingredientes')


    visit root_path
    click_on "Bolo de Cenoura"

    expect(page).to have_content("Receita de #{user.email}")
  end

  scenario 'and cant access the link directly' do
    recipe_type = RecipeType.create!(name: 'Sobremesa')
    cuisine = Cuisine.create!(cuisine_name: 'Brasileira')

    visit new_recipe_path
  
    expect(current_path).to eq new_user_session_path
  end
end
