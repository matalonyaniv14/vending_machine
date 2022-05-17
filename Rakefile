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

task :coin_repository do
  desc "Launch tests for coin_repository"
  sh "rspec -t coin_repository"
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

desc "Launch all model tests"
task models: [:coin, :product]

desc "launch all repository tests"
task repositories: [:coin_repository]

desc "launch all controller tests"
task controllers: [:vending_machine_controller]

desc "launch all service tests"
task services: [:calculate_change_service]
