# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/convert/webp/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-convert-webp"
  spec.version       = Rack::Convert::Webp::VERSION
  spec.authors       = ["Yuichi Tateno"]
  spec.email         = ["hotchpotch@gmail.com"]
  spec.summary       = %q{rack convert webp}
  spec.description   = %q{rack convert webp}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"
  spec.add_dependency "webp-ffi"
  spec.add_dependency "rack-accept-media-types"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
