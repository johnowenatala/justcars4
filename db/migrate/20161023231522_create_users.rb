class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, nullable: false, index: true
      t.string :password, nullable: false
      t.boolean :active
      t.integer :sign_in_count
      t.datetime :last_sign_in_at

      t.timestamps null: false
    end
  end
end
