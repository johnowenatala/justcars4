class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.references :model, index: true, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :price, null: false
      t.string :image_file_name, null: false

      t.timestamps null: false
    end
  end
end
