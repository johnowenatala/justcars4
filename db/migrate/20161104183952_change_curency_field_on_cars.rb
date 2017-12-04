class ChangeCurencyFieldOnCars < ActiveRecord::Migration
  def change
    # rename typo
    rename_column :cars, :curency, :currency
    # add default value = 0
    change_column :cars, :currency, :integer, default: 0
    # change all existent cars to have this default value
    Car.update_all(currency: 0)
  end
end
