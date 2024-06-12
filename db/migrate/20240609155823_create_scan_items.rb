class CreateScanItems < ActiveRecord::Migration[7.1]
  def change
    create_table :scan_items do |t|
      t.references :location, null: false, foreign_key: true
      t.references :scan, null: false, foreign_key: true
      t.boolean :occupied
      t.boolean :scanned
      t.string :detected_barcodes, array: true

      t.timestamps
    end
  end
end
