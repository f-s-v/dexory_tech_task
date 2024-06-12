class ComparisonReportItem < ApplicationRecord
  belongs_to :location
  belongs_to :comparison_report
  has_many :scan_items, foreign_key: 'location_id', primary_key: 'location_id'
end
