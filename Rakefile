require 'rspec/core'
require 'rspec/core/rake_task'

task default: :spec

desc 'Run all the tests'
RSpec::Core::RakeTask.new(:spec)

desc 'Run the product Checkout data'
task :Checkout do

  project_root = File.dirname(File.absolute_path(__FILE__))
  Dir.glob(project_root + '/../lib/*') { |file| require file }

  

end
