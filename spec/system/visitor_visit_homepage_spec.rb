require 'rails_helper'

describe 'Visitante visita a app' do
  it 'e é solicitado login' do
    visit root_path

    expect(current_path).to eq(new_admin_session_path)
  end
end
