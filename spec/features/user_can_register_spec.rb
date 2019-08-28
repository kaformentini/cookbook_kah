require 'rails_helper'

feature 'User can register' do
    scenario 'successfully' do
        user = User.create!(email: 'email@email.com', password: '123456')

        visit root_path
        click_on "Iniciar sessão"

        #within('form') do

            fill_in "Email", with: user.email
            fill_in "Password", with: '123456'
            click_on "Entrar"
       # end

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Olá email@email.com")
        expect(page).not_to have_content("Entrar")
        expect(page).to have_content("Sair")

    end

    scenario 'and can singout' do
        user = User.create!(email: 'email@email.com', password: '123456')

        visit root_path
        click_on "Iniciar sessão"

        #within('form') do

            fill_in "Email", with: user.email
            fill_in "Password", with: '123456'
            click_on "Entrar"

            click_on 'Sair'
       # end

        expect(current_path).to eq(root_path)
        expect(page).to have_content('Iniciar sessão')
        expect(page).not_to have_content("Sair")

    end

    scenario 'and can do his firs register' do
        
        visit root_path
        click_on "Registrar-se"

        #within('form') do

            fill_in "Email", with: "email@email.com"
            fill_in "Password", with: '123456'
            fill_in "Password confirmation", with: '123456'
            click_on "Registrar"

    
       # end

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Enviar uma receita")
        expect(page).to have_content("Sair")

    end


end
