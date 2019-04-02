class Item < ApplicationRecord
  enum status: [:owned, :stolen, :robbed]

  belongs_to :item_type
  belongs_to :brand
  has_one_attached :photo
  validates :title, :item_type, :registry_number, :brand, presence: true
end
