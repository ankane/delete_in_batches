require_relative "test_helper"

class TestDeleteInBatches < Minitest::Unit::TestCase

  def test_basic
    10.times do
      Tweet.create(user_id: 1)
    end
    Tweet.create(user_id: 2)

    Tweet.where(user_id: 1).delete_in_batches(batch_size: 2)

    assert_equal 1, Tweet.count
    assert_equal 2, Tweet.first.user_id
  end

  def test_progress
    10.times do
      Tweet.create(user_id: 1)
    end

    i = 0
    Tweet.where(user_id: 1).delete_in_batches(batch_size: 2) do
      i += 1
    end

    assert_equal 5, i
  end

end
