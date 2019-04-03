class Report < ApplicationRecord
  belongs_to :item
  has_one_attached :police_report
end
