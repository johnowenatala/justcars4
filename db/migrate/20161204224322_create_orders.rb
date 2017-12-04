class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :car, index: true, foreign_key: true
      t.string :name
      t.string :phone
      t.string :email
      t.integer :status
      t.text :comment

      t.timestamps null: false
    end
  end
end
