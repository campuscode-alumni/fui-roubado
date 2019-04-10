class ItemFound < ApplicationRecord
  belongs_to :item
  validates :message, presence: true
end
