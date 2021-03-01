# delete_in_batches

:fire: Fast batch deletes for Active Record

[![Build Status](https://github.com/ankane/delete_in_batches/workflows/build/badge.svg?branch=master)](https://github.com/ankane/delete_in_batches/actions)

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'delete_in_batches'
```

## How to Use

Delete rows in batches

```ruby
Tweet.where(user_id: 1).delete_in_batches
```

**Important:** Be sure to test your query before running it in production

Change the batch size

```ruby
Tweet.where(user_id: 1).delete_in_batches(batch_size: 50000) # defaults to 10000
```

Sleep between batches [master]

```ruby
Tweet.where(user_id: 1).delete_in_batches(sleep: 0.01)
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

**Note:** This project was originally described as “the fastest way to delete 100k+ rows with ActiveRecord” but a single `DELETE` statement will likely be faster. See [this discussion](https://github.com/ankane/delete_in_batches/issues/4) for more details.

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
