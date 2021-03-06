class List < ApplicationRecord
  belongs_to :user

  has_many :cards, dependent: :destroy

  # 文字数が1文字以上255文字以下であるかどうかを検証するバリデーション
  validates :title, length: { in: 1..255 }
end
