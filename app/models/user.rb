class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :city
  validates :name, :cpf, presence: true
  has_one_attached :photo
  has_many :items, dependent: :destroy
  has_many :reports, dependent: :nullify
end
