require 'rails_helper'

RSpec.describe Brand, type: :model do

  context 'with name' do

    let(:valid_brand) { Brand.new(name: 'BMW') }

    it 'is valid' do
      expect( valid_brand ).to be_valid
    end

    it 'can be saved' do
      expect( valid_brand.tap{|b| b.save } ).to be_persisted
    end

  end

  context 'without name' do
    it 'is invalid' do
      expect( Brand.new ).to_not be_valid
    end
  end

end
