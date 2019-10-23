require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'

class PatronTest < MiniTest::Test

  def setup
    @bob = Patron.new("Bob", 20)
  end

  def test_it_exists
    assert_instance_of Patron, @bob
  end

  def test_it_initializes
    assert_equal "Bob", @bob.name
    assert_equal 20, @bob.spending_money
  end

  def test_it_starts_with_no_interests
    assert_equal [], @bob.interests
  end

  def test_it_can_add_interests
    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")
    assert_equal 2, @bob.interests.size
    assert_equal true, @bob.interests.include?("Dead Sea Scrolls")
    assert_equal true, @bob.interests.include?("Gems and Minerals")
  end
end
