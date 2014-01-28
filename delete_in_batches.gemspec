# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'delete_in_batches/version'

Gem::Specification.new do |spec|
  spec.name          = "delete_in_batches"
  spec.version       = DeleteInBatches::VERSION
  spec.authors       = ["Andrew Kane"]
  spec.email         = ["andrew@chartkick.com"]
  spec.summary       = %q{The fastest way to delete millions of rows with ActiveRecord}
  spec.description   = %q{The fastest way to delete millions of rows with ActiveRecord}
  spec.homepage      = "https://github.com/ankane/delete_in_batches"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
