require_relative "lib/delete_in_batches/version"

Gem::Specification.new do |spec|
  spec.name          = "delete_in_batches"
  spec.version       = DeleteInBatches::VERSION
  spec.summary       = "The fastest way to delete 100k+ rows with ActiveRecord"
  spec.homepage      = "https://github.com/ankane/delete_in_batches"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "activerecord", ">= 5"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "sqlite3"
end
