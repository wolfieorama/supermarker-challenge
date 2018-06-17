class DiscountingService

  def initialize(rules = [])
    @rules = rules
  end

  def price_used(product, count)
    new_price = nil

    rules.each do |rule|
      if rule.discount__rule_type = Rule::DISCOUNT_RULE_TYPES[:two_or_more]
        new_price = rule.apply_discount(product_code, product_count)
      end
    end

    if new_price.nil?
      product.price
    else
      new_price
    end
  end

  private

  attr_reader :rules
end
