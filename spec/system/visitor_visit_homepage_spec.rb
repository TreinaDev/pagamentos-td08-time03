require 'rails_helper'

describe 'Visitante visita a app' do
  xit 'com sucesso' do
    visit root_path

    expect(page).to have_content 'USERUBIS'
  end
end
