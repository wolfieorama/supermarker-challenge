require 'spec_helper'

describe Rule do
  subject { Rule.new(Rule::DISCOUNT_RULE_TYPE[:two_or_more]) {} }

  describe 'DISCOUNT_RULE_TYPE' do
    it 'should return the discount type as a value of the enum' do
      expect(subject.discount_rule_type).to eq(0)
    end
  end

  describe 'creating rule factory' do
    it 'should call block with no arguments' do
      value = false
      rule = Rule.new(Rule::DISCOUNT_RULE_TYPE[:spent_over])do
        value = true
      end
      expect(rule.apply).to be_truthy
    end

    it 'should call block with one argument' do
      rule = Rule.new(Rule::DISCOUNT_RULE_TYPE[:spent_over])do|value|
        value
      end
      expect(rule.apply('foo')).to eq('foo')
    end

    it 'should call block with one argument' do
      rule = Rule.new(Rule::DISCOUNT_RULE_TYPE[:spent_over])do|value1, value2|
        "#{value1}-#{value2}"
      end
      expect(rule.apply('foo', 'bar')).to eq('foo-bar')
    end
  end

end
