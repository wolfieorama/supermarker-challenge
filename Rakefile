require 'rspec/core'
require 'rspec/core/rake_task'

task default: :spec

desc 'Run all the tests'
RSpec::Core::RakeTask.new(:spec)

desc 'Run the product Checkout data'
task :checkout do

  project_root = File.dirname(File.absolute_path(__FILE__))
  Dir.glob(project_root + '/lib/*') { |file| require file }

  # setting up the promo rules

  promotional_rules = []
  promotional_rules << Rule.spent_over(30, 10)
  promotional_rules << Rule.two_or_more('002', 3.99, 2)


  # Setting up products

  product1 = Product.new('001', 'Curry Sauce', 1.95)
  product2 = Product.new('002', 'Pizza', 5.99)
  product3 = Product.new('003', 'Men T=Shirt', 25.00)

  puts "---------------------------------Test 1: --------------------------------"

  checkout = Checkout.new(promotional_rules)
  checkout.scan_item(product1)
  checkout.scan_item(product2)
  checkout.scan_item(product3)

  puts "The Total to be paid:  #{checkout.total}"

  puts "---------------------------------Test 2: --------------------------------"

  checkout = Checkout.new(promotional_rules)
  checkout.scan_item(product2)
  checkout.scan_item(product1)
  checkout.scan_item(product2)

  puts "The Total to be paid:  #{checkout.total}"

  puts "---------------------------------Test 3: --------------------------------"

  checkout = Checkout.new(promotional_rules)
  checkout.scan_item(product2)
  checkout.scan_item(product1)
  checkout.scan_item(product2)
  checkout.scan_item(product3)

  puts "The Total to be paid:  #{checkout.total}"

end
