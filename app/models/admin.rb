class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :cpf, presence: true
  validates :cpf, length: {is: 11}
  validates :full_name, :cpf, uniqueness: true
  validates :email, format:{ with: %r{[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@userubis.com.br\z} }
end
