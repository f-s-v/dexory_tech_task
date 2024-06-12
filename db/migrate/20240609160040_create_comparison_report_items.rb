class CreateComparisonReportItems < ActiveRecord::Migration[7.1]
  def change
    create_table :comparison_report_items do |t|
      t.references :location, null: false, foreign_key: true, null: true
      t.string :expected_barcodes, array: true

      t.timestamps
    end
  end
end
