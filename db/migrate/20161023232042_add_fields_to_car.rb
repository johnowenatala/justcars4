class AddFieldsToCar < ActiveRecord::Migration
  def change
    change_table :cars do |t|
      t.string :color
      t.string :fuel
      t.integer :curency
      t.text :description
    end
  end
end
