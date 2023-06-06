class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :project_companies, through: :projects
  belongs_to :company, optional: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :photo
end
