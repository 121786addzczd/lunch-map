class User < ApplicationRecord
  has_one_attached :image

  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
end
