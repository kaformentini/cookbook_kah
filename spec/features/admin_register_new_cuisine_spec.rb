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

    pending 

    scenario 'recipe type is required' do

        visit root_path
        click_on 'Registrar Tipo de Receita'

        fill_in 'Tipo', with: ''
        click_on 'Enviar'

        expect(page).to have_content('Você deve preencher o campo TIPO')

    end 

    pending
    scenario 'recipe type has to be unique' do
        recipe_type = RecipeType.create(name: 'Sobremesa')
       
        visit root_path
        click_on 'Registrar Tipo de Receita'

        fill_in 'Tipo', with: 'Sobremesa'
        click_on 'Enviar'

        expect(page).to have_content('Tipo de receita já cadastrado')

    end



end

