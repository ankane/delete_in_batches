require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"

ENV["RACK_ENV"] = "test"

# for debugging
# ActiveRecord::Base.logger = Logger.new(STDOUT)

# rails does this in activerecord/lib/active_record/railtie.rb
ActiveRecord::Base.default_timezone = :utc
ActiveRecord::Base.time_zone_aware_attributes = true

# migrations
ActiveRecord::Base.establish_connection :adapter => "postgresql", :database => "delete_in_batches_test"

ActiveRecord::Migration.create_table :tweets, :force => true do |t|
  t.integer :user_id
end

ActiveRecord::Migration.create_table :users, :force => true do |t|
end

class Tweet < ActiveRecord::Base
  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :tweets
end
