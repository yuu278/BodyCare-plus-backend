class User < ApplicationRecord
  has_secure_password

  has_many :body_assessments, dependent: :destroy
  has_many :user_stretches, dependent: :destroy
  has_many :stretches, through: :user_stretches

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, on: :create
end
