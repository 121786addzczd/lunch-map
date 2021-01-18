class Card < ApplicationRecord
  belongs_to :list

  with_options presence: true do
    validates :title, length: { in: 1..255 }
    validates :memo,  length: { maximum: 1000 }
  end
end