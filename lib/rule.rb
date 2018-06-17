class Rule
  attr_reader :discount_rule_type

  DISCOUNT_RULE_TYPE = { two_or_more: 0, spent_over: 1 }

  def initialize(discount_rule_type, &block)
    @discount_rule_type = discount_rule_type
    @block  = block
  end

  def apply(*params)
    if block.arity == 0
      block.call
    elsif block.arity == 1
      block.call(params[0])
    elsif block.arity == 2
      block.call(params[0], params[1])
    end
  end

    # rule for offering a discount based on buying 2 or more pizzas
  def self.two_or_more(product_code, discount_price, product_count)
    Rule.new(Rule::DISCOUNT_RULE_TYPE[:two_or_more]) do |code, count|
      if code == product_code && count >= product_count
        discount_price
      end
    end
  end

  # rule for offering a discount based total price if its above 30 Euros
  def self.spent_over(spent_amt, discount_rate)
    Rule.new(Rule::DISCOUNT_RULE_TYPE[:spent_over]) do |amt|
      if amt >= spent_amt
        amt - amt * (discount_rate / 100)
      else
        amt
      end
    end
  end

  private

  attr_reader :block
end
