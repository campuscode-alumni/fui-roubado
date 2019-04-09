class Report < ApplicationRecord
  has_one_attached :police_report
  has_many :items, dependent: :nullify
  validates :ocurrance_date, :address, presence: true
  belongs_to :user
end
