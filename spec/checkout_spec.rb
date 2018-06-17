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

  context 'with no rules' do
    describe 'scanning products' do
      let(:product) { ProductStub.new('1', 'pname', 10) }

      it 'should calculate total as the product price' do
        subject.scan_item(product)
        expect(subject.total).to eq(10)
      end

      it 'should calculate subtotal as the cumulative product prices' do
        subject.scan_item(product)
        subject.scan_item(product)
        expect(subject.total).to eq(20)
      end

      it 'should round total to two decimal places' do
        product = ProductStub.new('2', 'name2', 15.156)
        subject.scan_item(product)
        expect(subject.total).to eq(15.16)
      end
    end
  end

  context 'with pricing rules' do
    let(:product) { ProductStub.new('1', 'name', 50) }

    describe 'scanning products' do
      before do
        allow_any_instance_of(DiscountingService).to receive(:price_used) { 25 }
        subject.scan_item(product)
      end

      it 'should ask pricing_service' do
        expect_any_instance_of(DiscountingService).to receive(:price_used).with(product, 1) { 25 }
        subject.total
      end

      it 'should use price from service' do
        expect(subject.total).to eq(25)
      end

      it 'should not affect total' do
        expect(subject.total).to eq(25)
      end
    end
  end

end
