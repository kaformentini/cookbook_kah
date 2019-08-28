require 'rails_helper'

feature 'Admin register new cuisine' do
    scenario 'successfully' do
        

        visit root_path
        click_on 'Registrar Tipo de Cozinha'

        fill_in 'Tipo', with: 'Brasileira'
        click_on 'Enviar'

        expect(page).to have_content('Regitro efetuado com sucesso!')
        expect(page).to have_content('Brasileira')
    end

    
    scenario 'cuisine is required' do

        visit root_path
        click_on 'Registrar Tipo de Cozinha'

        fill_in 'Tipo', with: ''
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher todos os campos')

    end 

    
    scenario 'cuisine has to be unique' do
        cuisine = Cuisine.create(cuisine_name: 'BR')
       
        visit root_path
        click_on 'Registrar Tipo de Cozinha'

        fill_in 'Tipo', with: 'BR'
        click_on 'Enviar'

        expect(page).to have_content('Tipo de cozinha já cadastrado')

    end



end

