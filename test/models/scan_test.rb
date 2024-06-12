require "test_helper"
require 'json'

class ScanTest < ActiveSupport::TestCase
  test "create_from_import" do
    import = JSON.parse file_fixture('scan_import.json').read
    assert_difference 'ScanItem.count', import.size do
      Scan.create_from_import(import)
    end
  end

  test "create_report_from_csv" do
    import = JSON.parse file_fixture('scan_import.json').read
    scan = Scan.create_from_import(import)
    report = file_fixture('scan_report.csv').read
    assert_difference 'ComparisonReportItem.count', report.lines.size - 1 do
      scan.create_report_from_csv(report)
    end
  end
end
