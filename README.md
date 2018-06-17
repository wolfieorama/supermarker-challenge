# supermarker-challenge

A simple supermarket checkout system

- to run the spec
  `rake`

- to run lib
  `rake checkout`

- to add new product in the rake file

  add extra products below these

  # Setting up products

  product1 = Product.new('001', 'Curry Sauce', 1.95)
  product2 = Product.new('002', 'Pizza', 5.99)
  product3 = Product.new('003', 'Men T=Shirt', 25.00)
  more products here

- to add new rules, define different discount rates here

  # setting up the promo rules

  promotional_rules = []
  promotional_rules << Rule.spent_over(30, 10)
  promotional_rules << Rule.two_or_more('002', 3.99, 2)
