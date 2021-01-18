class Category < ApplicationRecord
  has_many :shops

  validates :name,
  presence: true, uniqueness: true,
  length: { maximum: 10 }
end
