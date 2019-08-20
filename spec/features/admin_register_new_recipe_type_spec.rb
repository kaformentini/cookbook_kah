require 'rails_helper'

feature 'Admin register new recipe type' do
    scenario 'successfully' do
        

        visit root_path
        click_on 'Registar Tipo de Receita'

        fill_in 'Tipo', with: "Sobremesa"
        click_on "Enviar"

        expect(page).to have_content('Regitro efetuado com sucesso!')
        expect(page).to have_content('Sobremesa')
    end
end

