require_relative "test_helper"

class TestDeleteInBatches < Minitest::Test
  def setup
    User.delete_all
    Tweet.delete_all
  end

  def test_basic
    create_tweets
    Tweet.create!(user_id: 2)

    Tweet.where(user_id: 1).delete_in_batches(batch_size: 2)

    assert_equal 1, Tweet.count
    assert_equal 2, Tweet.first.user_id
  end

  def test_all
    Tweet.create!(user_id: 1)

    Tweet.delete_in_batches

    assert_equal 0, Tweet.count
  end

  def test_sleep
    create_tweets

    started_at = Time.now
    Tweet.where(user_id: 1).delete_in_batches(batch_size: 2, sleep: 0.01)
    assert_operator(Time.now - started_at, :>=, 0.05)
  end

  def test_progress
    create_tweets

    i = 0
    Tweet.where(user_id: 1).delete_in_batches(batch_size: 2) do
      i += 1
    end

    assert_equal 5, i
  end

  def test_association
    user = User.create!
    user.tweets.create!

    user.tweets.delete_in_batches

    assert_equal 0, user.tweets.count
  end

  def test_join
    user = User.create!
    user.tweets.create!

    Tweet.joins(:user).where(users: {id: user.id}).delete_in_batches

    assert_equal 0, Tweet.count
  end

  def create_tweets
    tweets = 10.times.map { {user_id: 1} }
    if Tweet.respond_to?(:insert_all)
      Tweet.insert_all(tweets)
    else
      Tweet.create!(tweets)
    end
  end
end
