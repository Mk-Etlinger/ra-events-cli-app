# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ra_events/version'

Gem::Specification.new do |spec|
  spec.name          = "ra_events"
  spec.version       = RaEvents::VERSION
  spec.authors       = ["Mike Etlinger"]
  spec.email         = ["mk.etlinger@gmail.com"]

  spec.summary       = %q{ra-events lists events by state right to your terminal}
  spec.description   = %q{Type in your state, get a list of events by week, and open an event in your browser for more details.}
  spec.homepage      = "https://github.com/Mk-Etlinger/ra-events-cli-app"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  
end
