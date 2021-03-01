require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "active_record"

ActiveRecord::Base.logger = ActiveSupport::Logger.new(ENV["VERBOSE"] ? STDOUT : nil)

# rails does this in activerecord/lib/active_record/railtie.rb
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.time_zone_aware_attributes = true

# migrations
connection_spec =
  case ENV["ADAPTER"]
  when "postgresql"
    {adapter: "postgresql", database: "delete_in_batches_test"}
  when "mysql2"
    {adapter: "mysql2", database: "delete_in_batches_test"}
  else
    {adapter: "sqlite3", database: ":memory:"}
  end

ActiveRecord::Base.establish_connection(connection_spec)
ActiveRecord::Schema.verbose = ENV["VERBOSE"]
ActiveRecord::Schema.define do
  create_table :tweets, force: true do |t|
    t.integer :user_id
  end

  create_table :users, force: true do |t|
  end
end

class Tweet < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :tweets
end

# for debugging
# ActiveRecord::Base.logger = Logger.new(STDOUT)
