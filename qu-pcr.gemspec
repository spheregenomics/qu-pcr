# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qu/pcr/version'

Gem::Specification.new do |spec|
  spec.name          = "qu-pcr"
  spec.version       = Qu::Pcr::VERSION
  spec.authors       = ["Wubin Qu"]
  spec.email         = ["quwubin@gmail.com"]
  spec.description   = %q{A package for PCR, including primers, products, primer3 parser, virtual electrophoresis, etc.}
  spec.summary       = %q{A ruby library for PCR}
  spec.homepage      = "https://github.com/quwubin/qu-pcr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'qu-utils', '~> 1.0'
  spec.add_runtime_dependency 'qu-cmdwrapper', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
