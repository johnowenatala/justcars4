class Model < ActiveRecord::Base
  belongs_to :brand
  has_many :cars

  validates :name, :brand, presence: true

  def make_id
    brand.make_id
  end

  def brand_name
    brand.name
  end
end
