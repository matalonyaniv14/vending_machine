require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob("spec/**/*_spec.rb")
end

desc "Launch tests for coin"
task :coin do
  sh "rspec -t coin"
end

desc "Launch tests for product"
task :product do
  sh "rspec -t product"
end

desc "Launch tests for base_repository"
task :base_repository do
  sh "rspec -t base_repository"
end

task :coin_repository do
  desc "Launch tests for coin_repository"
  sh "rspec -t coin_repository"
end

desc "Launch tests for product_repository"
task :product_repository do
  sh "rspec -t product_repository"
end

desc "Launch tests for vending_machine_controller"
task :vending_machine_controller do
  sh "rspec -t vending_machine_controller"
end

desc "Launch tests for calculate_change_service"
task :calculate_change_service do
  sh "rspec -t calculate_change_service"
end

task default: [:spec]
task models: [:coin, :product]
task repositories: [:base_repository, :coin_repository, :product_repository]
task controllers: [:vending_machine_controller]
task services: [:calculate_change_service]
