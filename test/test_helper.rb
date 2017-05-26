require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"

ENV["RACK_ENV"] = "test"

Minitest::Test = Minitest::Unit::TestCase unless defined?(Minitest::Test)

# rails does this in activerecord/lib/active_record/railtie.rb
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.time_zone_aware_attributes = true

# migrations
connection_spec =
  if defined?(Mysql2)
    {adapter: "mysql2", database: "delete_in_batches_test", username: "root"}
  else
    {adapter: "sqlite3", database: ":memory:"}
  end

ActiveRecord::Base.establish_connection(connection_spec)

ActiveRecord::Migration.create_table :tweets, force: true do |t|
  t.integer :user_id
end

ActiveRecord::Migration.create_table :users, force: true do |t|
end

class Tweet < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :tweets
end

# for debugging
# ActiveRecord::Base.logger = Logger.new(STDOUT)
