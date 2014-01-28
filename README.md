# delete_in_batches

:fire: The fastest way to delete 100k+ of rows with ActiveRecord

## Slow

```ruby
Tweet.where(user_id: 1).delete_all
# DELETE FROM tweets WHERE user_id = 1
```

The database performs the delete in a transaction - either all the records are deleted (query completes) or none are, due to [multiversion concurrency control](http://en.wikipedia.org/wiki/Multiversion_concurrency_control).

## Fast

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

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "delete_in_batches"
```

And then execute:

```sh
bundle
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/delete_in_batches/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/delete_in_batches/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
