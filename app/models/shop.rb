class Shop < ApplicationRecord
  belongs_to :category
  # addressを登録した際にgeocoderが緯度、経度のカラムにも自動的に値を入れてくれるようになる
  geocoded_by :address
  # addressを登録された後にlatitude(緯度),longitude(経度)が登録される
  after_validation :geocode, if: :address_changed?
end
