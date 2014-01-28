require_relative "test_helper"

class TestDeleteInBatches < Minitest::Unit::TestCase

  def setup
    User.delete_all
    Tweet.delete_all
  end

  def test_basic
    10.times do
      Tweet.create!(user_id: 1)
    end
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

  def test_progress
    10.times do
      Tweet.create!(user_id: 1)
    end

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

end
