
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "entitize/version"

Gem::Specification.new do |spec|
  spec.name          = "entitize"
  spec.version       = Entitize::VERSION
  spec.authors       = ["Stephen Fiser"]
  spec.email         = ["stephen@bluebear.tech"]

  spec.summary       = %q{ Entitize is a library that makes working with external APIs easier. }
  spec.description   = %q{ Entitize is a library that makes working with external APIs easier... more later }
  spec.homepage      = "https://www.bluebear.tech"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

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
