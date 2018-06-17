class DiscountingService

  def initialize(rules = [])
    @rules = rules
  end

  def price_used(product, count) # when buyer buy more than 2 product of same discount_rule_type
    new_price = nil

    rules.each do |rule|
      if rule.discount_rule_type == Rule::DISCOUNT_RULE_TYPE[:two_or_more]
        new_price = rule.apply(product.product_code, count)
      end
    end

    if new_price.nil?
      product.price
    else
      new_price
    end
  end

  def apply_discounts(subtotal) # when user exceeds a certain amount of total purchases
    total = subtotal

    rules.each do |rule|
      if rule.discount_rule_type == Rule::DISCOUNT_RULE_TYPE[:spent_over]
        total = rule.apply(total)
      end
    end

    total
  end

  private

  attr_reader :rules
end
