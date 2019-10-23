require 'minitest/autorun'
require 'minitest/pride'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MuseumTest < MiniTest::Test

  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")
    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_initializes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
  end

  def test_it_starts_with_no_exhibits
    assert_equal [], @dmns.exhibits
  end

  def test_it_can_add_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal 3, @dmns.exhibits.size
    assert_equal true, @dmns.exhibits.include?(@gems_and_minerals)
    assert_equal true, @dmns.exhibits.include?(@dead_sea_scrolls)
    assert_equal true, @dmns.exhibits.include?(@imax)
  end

  def test_it_can_recommend_exhibits
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    assert_equal [@dead_sea_scrolls, @gems_and_minerals], @dmns.recommend_exhibits(bob)
    assert_equal [@imax], @dmns.recommend_exhibits(sally)
  end

  def test_it_starts_with_no_patrons
    assert_equal [], @dmns.patrons
  end

  def test_it_can_add_patrons
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")
    @dmns.admit(bob)
    @dmns.admit(sally)
    assert_equal 2, @dmns.patrons.size
    assert_equal true, @dmns.patrons.include?(bob)
    assert_equal true, @dmns.patrons.include?(sally)
  end

  def test_it_can_track_patrons_exhibit_intersts
    bob = Patron.new("Bob", 20)
    bob.add_interest("Dead Sea Scrolls")
    bob.add_interest("Gems and Minerals")
    sally = Patron.new("Sally", 20)
    sally.add_interest("IMAX")
    sally.add_interest("Dead Sea Scrolls")
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)
    @dmns.admit(bob)
    @dmns.admit(sally)
    @dmns.patrons_by_exhibit_interests(bob)
    @dmns.patrons_by_exhibit_interests(sally)
    assert_equal [bob, sally], @dmns.exhibit_by_interest[@dead_sea_scrolls]
  end

end
