require 'rails_helper'

RSpec.describe Model, type: :model do

  let(:brand) { Brand.create(name:'BMW') }

  context 'with name and brand' do

    let(:valid_model) { Model.new(name: 'X', brand: brand) }

    it 'is valid' do
      expect( valid_model ).to be_valid
    end

    it 'can be saved' do
      expect( valid_model.tap{|b| b.save } ).to be_persisted
    end

  end

  context 'with name no brand' do
    it 'is invalid' do
      expect( Model.new(name: 'X') ).to_not be_valid
    end
  end

  context 'with brand but no name' do
    it 'is invalid' do
      expect( Model.new(brand: brand) ).to_not be_valid
    end
  end

end
