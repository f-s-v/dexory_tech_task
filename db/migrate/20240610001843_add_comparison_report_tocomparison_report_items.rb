class AddComparisonReportTocomparisonReportItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :comparison_report_items, :comparison_report, index: true
  end
end
