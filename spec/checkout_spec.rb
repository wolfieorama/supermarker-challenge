require 'spec_helper'

describe Checkout do
  ProductStub = Struct.new(:product_code, :name, :price)
  subject { Checkout.new }

  describe 'initializing' do
    it 'should start with empty total' do
      expect(subject.total).to eq(0.0)
    end

    it 'should start with empty subtotal' do
      expect(subject.total).to eq(0.0)
    end
  end

end
