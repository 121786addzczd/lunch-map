class Address < ApplicationRecord
  belongs_to :user, optional: true # optional: trueを設定することで、外部キーがnilであってもDBに保存することができる
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン(-)含む必要があります' }
    validates :address
  end
end
