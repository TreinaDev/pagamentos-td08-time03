class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :approvals

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :cpf, presence: true
  validates :cpf, length: {is: 11}
  validates :full_name, :cpf, uniqueness: true
  validates :email, format:{ with: %r{\A[\w\-\+]+@userubis.com.br\z} }

  enum activation: {not_approved: 0, half_approved: 5, approved: 10}

end
