class Shop < ApplicationRecord
  belongs_to :category
  has_one_attached :image
  # addressを登録した際にgeocoderが緯度、経度のカラムにも自動的に値を入れてくれるようになる
  geocoded_by :address
  # addressを登録された後にlatitude(緯度),longitude(経度)が登録される
  after_validation :geocode, if: :address_changed?

  validates :name, presence: true
  validates :address, presence: true
  validates :image, presence: true
end
