require_relative "lib/delete_in_batches/version"

Gem::Specification.new do |spec|
  spec.name          = "delete_in_batches"
  spec.version       = DeleteInBatches::VERSION
  spec.summary       = "Fast batch deletes for Active Record and Postgres"
  spec.homepage      = "https://github.com/ankane/delete_in_batches"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "activerecord", ">= 5"
end
