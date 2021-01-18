class User < ApplicationRecord
  has_one_attached :image
  has_secure_password
  has_many :lists, dependent: :destroy

  with_options presence: true do
    validates :name, length: { in: 2..10 }
    validates :email, { uniqueness: true }
    validates :password, length: { in: 6..50 }, on: :create
    validates :password, confirmation: true, on: :create
  end
  validates :profile,length: { maximum: 500 }
end
