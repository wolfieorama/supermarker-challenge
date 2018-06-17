require 'spec_helper'

describe DiscountingService do

  let(:rule) { double('rule') }
  let(:product) { Struct.new(:product_code, :name, :price).new('1', 'name', 0.99) }
  subject { DiscountingService.new([rule]) }


  describe '#price_used' do
    before do
      allow(rule).to receive(:discount_rule_type) { Rule::DISCOUNT_RULE_TYPE[:two_or_more] }
      allow(rule).to receive(:apply) { 100 }
    end

    it 'should pass the calculation to the pricing rule with params' do
      expect(rule).to receive(:discount_rule_type) { Rule::DISCOUNT_RULE_TYPE[:two_or_more] }
      expect(rule).to receive(:apply).with(product.product_code, 1)

      subject.price_used(product, 1)
    end

    it 'should return the calculated price for product when rule matches' do
      price = subject.price_used(product, 1)
      expect(price).to eq(100)
    end

    it 'should return the original price if no rule match' do
      discounting_service = DiscountingService.new

      price = discounting_service.price_used(product, 1)
      expect(price).to eq(product.price)
    end
  end

  describe '#apply_discounts' do
    before do
      allow(rule).to receive(:discount_rule_type) { Rule::DISCOUNT_RULE_TYPE[:spent_over] }
      allow(rule).to receive(:apply) { 100 }
    end

    it 'should pass the calculation to the rule with subtotal' do
      expect(rule).to receive(:discount_rule_type) { Rule::DISCOUNT_RULE_TYPE[:spent_over] }
      expect(rule).to receive(:apply).with(10)

      subject.apply_discounts(10)
    end

    it 'should return the calculated total when rule match' do
      total = subject.apply_discounts(10)
      expect(total).to eq(100)
    end

    it 'should return original subtotal if no rule match' do
      discounting_service = DiscountingService.new

      total = discounting_service.apply_discounts(10)
      expect(total).to eq(10)
    end
  end
end
