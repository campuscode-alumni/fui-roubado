class Report < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  has_one_attached :police_report
  has_many :items, dependent: :nullify
  validates :ocurrance_date, :address, :items, presence: true
  belongs_to :user
end
