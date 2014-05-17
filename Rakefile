$LOAD_PATH.push File.expand_path("../lib", __FILE__)

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
