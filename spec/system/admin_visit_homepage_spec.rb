require 'rails_helper'

describe 'Admin visita a página inicial' do
  it 'está pendente de aprovação, e é solicitado login' do
    admin = create(:admin, :not_approved)

    login_as(admin)
    visit root_path

    expect(page).to have_content('Sua conta ainda falta ser ativada.')
  end

  it 'possui uma aprovação, e é solicitado login' do
    admin = create(:admin, :half_approved)

    login_as(admin)
    visit root_path

    expect(page).to have_content('Sua conta ainda falta ser ativada.')
  end

  it 'é totalmente aprovado e consegue acessar a aplicação' do
    admin = create(:admin, :approved)

    login_as(admin)
    visit root_path

    expect(page).to have_content('USERUBIS')
    within('nav') do
      expect(page).to have_link('Início')
      expect(page).to have_link('Aprovações Pendentes')
      expect(page).to have_content('joao@userubis.com.br')
      expect(page).to have_button('Sair')
      expect(page).to have_link('Cotação de Rubis')
    end
  end
end
