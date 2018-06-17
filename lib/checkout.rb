class Checkout

  def initialize( discount_service= [])
    @discount_service    = DiscountingService.new(pricing_rules)
    @basket             = []
  end
end
