class PopulateBrandsWithMakeId < ActiveRecord::Migration
  def up
    {
      'BMW' => 'bmw',
      'Mazda' => 'mazda',
      'Audi' => 'audi'
    }.each do |name, make_id|
      Brand.where(name: name).update_all(make_id: make_id)
    end
  end
  def down
  end
end
