class Rule
  attr_reader :discount_type, :block

  DISCOUNT_RULE_TYPES = {
    spent_over: 0,
    two_or_more: 1
  }

  def initialize(discount__rule_type)
    @discount__rule_type = discount__rule_type
    @block  = block
  end

  def human_type
    DISCOUNT_RULE_TYPES.key(@discount__rule_type)
  end

  def self.spent_over(spent_amt, discount_rate)
    Rule.new(Rule::DISCOUNT_RULE_TYPES) do |amt|
      if amt >= spent_amt
        amt - amt * (discount_rate / 100)
      else
        amt
      end
    end
  end

  def self.two_or_more(product_code, product_count, discount_price)
    Rule.new(Rule::DISCOUNT_RULE_TYPES[:two_or_more]) do |code, count|
      if code == product_code && count >= product_count
        discount_price
      end
    end
  end

  def apply_discount(*params)
    if block.arity == 0
      block.call
    elsif block.arity == 1
      block.call(params[0])
    elsif block.arity == 2
      block.call(params[0], params[1])
    else
      false
    end
  end
end
