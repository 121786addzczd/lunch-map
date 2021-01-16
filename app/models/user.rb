class User < ApplicationRecord
  has_one_attached :image
  has_secure_password

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  validates :password, length: { minimum: 6 }, on: :create
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create

end
