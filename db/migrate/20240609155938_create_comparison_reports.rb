class CreateComparisonReports < ActiveRecord::Migration[7.1]
  def change
    create_table :comparison_reports do |t|
      t.references :scan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
