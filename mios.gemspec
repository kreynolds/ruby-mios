# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mios/version'

Gem::Specification.new do |gem|
  gem.name          = "mios"
  gem.version       = MiOS::VERSION
  gem.authors       = ["Kelley Reynolds"]
  gem.email         = ["kelley.reynolds@rubyscale.com"]
  gem.description   = %q{Object-oriented interactions with MiOS from MiCasaVerde}
  gem.summary       = %q{Object-oriented interactions with MiOS from MiCasaVerde}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency "httpclient", ">= 2.2.0"
  gem.add_dependency "multi_json", ">= 1.3.0"
  
  gem.add_development_dependency "rspec", ">= 2.8.0"
  gem.add_development_dependency "syntax"
  gem.add_development_dependency "rake", ">= 0.9.2"
  gem.add_development_dependency "yard", ">= 0.7.2"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "vcr"
  gem.add_development_dependency "webmock"
  gem.add_development_dependency "simplecov"
end
