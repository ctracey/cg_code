$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec).pattern  = './spec/lib/flower_shop{,/*/**}/*_spec.rb'

desc 'test case that demonstrates the complete solution'
e2e_task = RSpec::Core::RakeTask.new(:e2e)
e2e_task.pattern  = './spec/lib/flower_shop_spec.rb'

task :default => :spec

desc 'run test, build gem and install gem'
task :ci => %w{spec gem:build gem:install}

namespace :gem do

  desc 'build the flower_shop gem'
  task :build do
    print_heading 'Building flower_shop gem'
    `gem build flower_shop.gemspec`
  end

  desc 'install flower_shop gem from local gem file'
  task :install do
    version = FlowerShop::VERSION
    print_heading "Installing flower_shop gem #{version}"
    `gem install ./flower_shop-#{version}.gem`
  end
end

def print_heading heading
    30.times.each { print '=' }
    puts
    puts heading
end
