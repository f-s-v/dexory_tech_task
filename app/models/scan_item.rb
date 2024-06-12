class ScanItem < ApplicationRecord
  belongs_to :location
  belongs_to :scan
end
