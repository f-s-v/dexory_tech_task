require "test_helper"

class ComparisonReportsHelperTest < ActionView::TestCase
  [
    [:empty, :not_scanned, :not_scanned_empty_expected, true],
    [:one, :not_scanned, :not_scanned_empty_unexpected, false],
    [:empty, :empty, :empty_expected, true],
    [:one, :empty, :empty_unexpected, false],
    [:one, :one, :occupied_correct, true],
    [:empty, :one, :occupied_wrong, false],
    [:empty, :occupied_no_barcodes, :occupied_no_barcodes, false],
  ].each do |(report, scan, status, success)|
    test "comparison_report_item_status, #{status}" do
      report_item = comparison_report_items(report)
      scan_item = scan_items(scan)
      item = OpenStruct.new scan_item.attributes.merge(report_item.attributes)
      assert_equal comparison_report_item_status(item), [status, success]
    end    
  end
end