class Checkout

  attr_reader :basket

  def initialize(pricing_rules = [])
    @discounting_service    = DiscountingService.new(pricing_rules)
    @basket             = []
  end

  def scan_item(item)
    basket << item
  end

  def total
    sub_total = 0.00

    basket.each do |product|
      products_in_basket = quantity_in_basket(product.product_code)
      sub_total += discounting_service.price_used(product, products_in_basket)
    end

    total = discounting_service.apply_discounts(sub_total)
    total.round(2)
  end

  def quantity_in_basket(product_code)
    count = 0

    basket.each do |product|
      count += 1 if product.product_code == product_code
    end

    count
  end

  private

  attr_reader :discounting_service
end
