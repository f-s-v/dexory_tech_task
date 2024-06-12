require 'csv'

class Scan < ApplicationRecord
  has_many :scan_items
  has_many :comparison_reports
  accepts_nested_attributes_for :scan_items

  def self.create_from_import(items)
    scan = Scan.create

    # create locations if not exist
    # and create scan items per import line

    requested_locations = items.map{|item| item["name"]}
    existing_locations = Location.where(name: requested_locations)
    # create missing locations (not previously scanned)
    Location.import(
      (requested_locations - existing_locations.map(&:name)).map do |name|
        {name: name}
      end
    )

    # cache locations list,
    location_name_to_id = Location.where(name: requested_locations).map{ |loc| [loc.name, loc.id]}.to_h

    # make a scan object and scan items
    ScanItem.import(items.map do |import_item|
      {
        scan_id: scan.id,
        location_id: location_name_to_id[import_item["name"]],
        occupied: import_item["occupied"],
        scanned: import_item["scanned"],
        detected_barcodes: import_item["detected_barcodes"]
      }
    end)

    scan
  end

  def create_report_from_csv(csv_text)
    report = ComparisonReport.create(scan: self)

    csv = CSV.new(csv_text)
    csv.shift

    report_items = {}
    csv.map do |(name, barcode)|
      report_items[name] ||= {
        name:,
        expected_barcodes: []
      }

      report_items[name][:expected_barcodes] << barcode if barcode
    end

    requested_locations = report_items.values.map{|item| item[:name]}
    existing_locations = Location.where(name: requested_locations)
    
    Location.import(
      (requested_locations - existing_locations.map(&:name)).map{ |name| { name: }}
    )    
    
    # pre-cache locations list,
    location_name_to_id = Location.where(name: requested_locations).map{ |loc| [loc.name, loc.id]}.to_h

    ComparisonReportItem.import(report_items.values.map do |item|
      {
        location_id: location_name_to_id[item[:name]],
        expected_barcodes: item[:expected_barcodes],
        comparison_report_id: report.id
      }
    end)

    report
  end
end
