module ComparisonReportsHelper
  def comparison_report_item_status(item)
    # The location hasn't been scanned, and it was empty
    if (!item.scanned && item.expected_barcodes.empty?)
      [:not_scanned_empty_expected, true]

    # The location was occupied, but no barcode could be identified
    elsif (item.occupied && item.detected_barcodes.empty?)
      [:occupied_no_barcodes, false]

    # The location hasn't been scanned, but it should have been occupied
    elsif (!item.scanned && item.expected_barcodes.present?)
      [:not_scanned_empty_unexpected, false]

    # The location was empty, as expected
    elsif (!item.occupied && item.detected_barcodes.empty?&& item.expected_barcodes.empty?)
      [:empty_expected, true]

    # The location was empty, but it should have been occupied
    elsif (!item.occupied && item.detected_barcodes.empty? && item.expected_barcodes.present?)
      [:empty_unexpected, false]

    # The location was occupied by the expected items
    elsif (item.occupied && item.detected_barcodes.present? && (item.detected_barcodes - item.expected_barcodes).empty?)
      [:occupied_correct, true]

    # The location was occupied by the wrong items
    elsif (item.occupied && item.detected_barcodes.present? && item.expected_barcodes.present? && (item.detected_barcodes - item.expected_barcodes).present?)
      [:occupied_incorrect, false]

    # The location was occupied by an item, but should have been empty
    elsif (item.occupied && item.expected_barcodes.empty? && item.detected_barcodes.present?)
      [:occupied_wrong, false]

    else
      [nil, true]
    end
  end
end
