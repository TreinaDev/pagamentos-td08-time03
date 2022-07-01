require 'rails_helper'

describe 'Admin aprova um outro admin' do
  it 'com sucesso' do
    admin = create(:admin, :approved)
    to_approve_admin = create(:admin, :pending, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                                     cpf: '12555778904', password: '123456')

    login_as(admin)
    post(create_admin_approvals_path(to_approve_admin),
         params: { approval: { admin: to_approve_admin, super_admin_email: admin.email } })

    expect(AdminApproval.last.admin).to eq(to_approve_admin)
    expect(AdminApproval.last.super_admin_email).to eq(admin.email)
    expect(Admin.last.activation).to eq('half_approved')
  end

  it 'com falha caso Admin aprovador não seja aprovado' do
    admin = create(:admin, :pending)
    to_approve_admin = create(:admin, :pending, full_name: 'Fernando', email: 'fernando@userubis.com.br',
                                                     cpf: '12555778904', password: '123456')

    login_as(admin)
    post(create_admin_approvals_path(to_approve_admin), params: { approval: { admin: admin, super_admin_email: admin.email } })

    expect(AdminApproval.all).to be_empty
    expect(Admin.last.activation).to eq('pending')
  end
end
