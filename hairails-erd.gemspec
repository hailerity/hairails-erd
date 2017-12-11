
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hairails/erd/version"

Gem::Specification.new do |spec|
  spec.name          = "hairails-erd"
  spec.version       = Hairails::Erd::VERSION
  spec.authors       = ["Hai Le"]
  spec.email         = ["hailerity@gmail.com"]

  spec.summary       = "Rails util for ERD"
  spec.description   = "Generate models from ERD in svg format exported from draw.io"
  spec.homepage      = "https://github.com/hailerity"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
