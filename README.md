# delete_in_batches

:fire: The fastest way to delete 100k+ rows with ActiveRecord

[![Build Status](https://github.com/ankane/delete_in_batches/workflows/build/badge.svg?branch=master)](https://github.com/ankane/delete_in_batches/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'delete_in_batches'
```

## Slow

```ruby
Tweet.where(user_id: 1).delete_all
# DELETE FROM tweets WHERE user_id = 1
```

## Faster

```ruby
Tweet.where(user_id: 1).in_batches(of: 10000).delete_all
# SELECT tweets.id FROM tweets WHERE user_id = 1 ORDER BY id LIMIT 1000
# DELETE FROM tweets WHERE user_id = 1 AND id IN (1, 2, 3, ...)
# ...
```

## Fastest

```ruby
Tweet.where(user_id: 1).delete_in_batches
# DELETE FROM tweets WHERE id IN (SELECT id FROM tweets WHERE user_id = 1 LIMIT 10000)
# DELETE FROM tweets WHERE id IN (SELECT id FROM tweets WHERE user_id = 1 LIMIT 10000)
# ...
```

**Important:** Be sure to test your query before running it in production

Change the batch size

```ruby
Tweet.where(user_id: 1).delete_in_batches(batch_size: 50000) # defaults to 10000
```

Show progress

```ruby
Tweet.where(user_id: 1).delete_in_batches do
  puts "Another batch deleted"
end
```

Works with associations

```ruby
user.tweets.delete_in_batches
```

To delete all rows in a table, `TRUNCATE` is fastest.

```ruby
ActiveRecord::Base.connection.execute("TRUNCATE tweets")
```

## History

View the [changelog](https://github.com/ankane/delete_in_batches/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/delete_in_batches/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/delete_in_batches/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/delete_in_batches.git
cd delete_in_batches
bundle install
bundle exec rake test
```
