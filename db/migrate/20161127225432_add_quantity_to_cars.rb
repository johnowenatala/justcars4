class AddQuantityToCars < ActiveRecord::Migration
  def change
    add_column :cars, :quantity, :integer
  end
end
