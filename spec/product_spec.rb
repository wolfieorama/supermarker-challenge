require 'spec_helper'

describe Product do
  before :each do
    @product = Product.new(001, "Sugar", 900)
  end

  it 'should return the product code' do
    expect(@product.product_code).to eq(001)
  end

  it 'should return the product name' do
    expect(@product.name).to eq("Sugar")
  end

  it 'should return the product name' do
    expect(@product.price).to eq(900)
  end
end
