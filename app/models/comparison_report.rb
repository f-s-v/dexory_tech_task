class ComparisonReport < ApplicationRecord
  belongs_to :scan
  has_many :comparison_report_items

  def items_with_scans
    self
      .comparison_report_items
      .includes(:location)
      .left_joins(:scan_items)
      .where("scan_items.scan_id" => self.scan_id)
      .select(
        "comparison_report_items.*",
        "scan_items.location_id as scans_location_id",
        "scan_items.detected_barcodes",
        "scan_items.scanned",
        "scan_items.occupied"
      )
  end
end
