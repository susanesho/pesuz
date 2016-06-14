lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pesuz/version"

Gem::Specification.new do |spec|
  spec.name          = "pesuz"
  spec.version       = Pesuz::VERSION
  spec.authors       = ["andela-oesho"]
  spec.email         = ["susan.esho@andela.com"]

  spec.summary       = "A simple mvc framework"
  spec.description   = "A simple mvc rack framework"
  spec.homepage      = "https://github.com/andela-oosiname/mgt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "rack", "~> 1.0"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "faker"

  spec.add_runtime_dependency "erubis"
  spec.add_runtime_dependency "pry"
  spec.add_runtime_dependency "sqlite3"
  spec.add_runtime_dependency "tilt"
end
