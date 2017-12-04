class AddMakeIdToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :make_id, :string, after: :name
  end
end
