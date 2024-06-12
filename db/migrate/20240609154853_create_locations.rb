class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name

      t.timestamps
    end
    add_index :locations, :name, unique: true
  end
end
