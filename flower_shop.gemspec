$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'flower_shop/version'

Gem::Specification.new do |gem|
  gem.name        = "flower_shop"
  gem.description = "flower shop invoicer executable gem"
  gem.version     = FlowerShop::VERSION
  gem.authors     = ["ctracey"]
  gem.email       = ["tracey.chris@gmail.com"]
  gem.homepage    = "https://github.com/ctracey/cg_code"
  gem.summary     = %q{Flower Shop Invoicer}

  gem.files         = Dir.glob("**/*")
  gem.test_files    = Dir.glob("{spec}/**/*")
  gem.executables   = Dir.glob("{bin}/*").map{ |file_path| File.basename(file_path) }
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'byebug'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_runtime_dependency "clamp"

end

