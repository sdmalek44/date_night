require 'minitest/autorun'
require 'minitest/pride'
require './lib/binary_search.rb'

class BinarySearchTest < Minitest::Test

  def test_if_it_exists
    tree = BinarySearchTree.new

    assert_instance_of BinarySearchTree, tree
  end

  def test_insert_and_include
    tree = BinarySearchTree.new

    assert_equal 0, tree.insert(88, 'movie', 0)
    assert_equal 1, tree.insert(66, 'movie2', 0)
    assert_equal 1, tree.insert(99, 'movie3', 0)
    assert_equal 2, tree.insert(55, 'movie4', 0)

    assert tree.include?(66)
    refute tree.include?(44)
  end

  def test_depth_of
    tree = BinarySearchTree.new
    tree.insert(80, 'movie')
    tree.insert(60, 'movie1')
    tree.insert(40, 'movie2')

    assert_equal 2, tree.depth_of(40)
    assert_equal 1, tree.depth_of(60)
    assert_nil tree.depth_of(50)
  end

  def test_max
    tree = BinarySearchTree.new
    tree.insert(88, 'movie', 0)
    tree.insert(66, 'movie2', 0)
    tree.insert(99, 'movie3', 0)
    tree.insert(55, 'movie4', 0)
    expected = {"movie3" => 99}
    actual = tree.max

    assert_equal expected, actual
  end

  def test_min
    tree = BinarySearchTree.new
    tree.insert(88, 'movie', 0)
    tree.insert(26, 'movie2', 0)
    tree.insert(90, 'movie3', 0)
    tree.insert(55, 'movie4', 0)
    expected = {"movie2" => 26}
    actual = tree.min

    assert_equal expected, actual
  end

  def test_sort
    tree = BinarySearchTree.new
    tree.insert(88, 'movie', 0)
    tree.insert(26, 'movie2', 0)
    tree.insert(90, 'movie3', 0)
    tree.insert(55, 'movie4', 0)

    expected = [{"movie2"=>26}, {"movie4"=>55}, {"movie"=>88}, {"movie3"=>90}]
    actual = tree.sort

    assert_equal expected, actual
  end

  def test_load
    tree = BinarySearchTree.new
    tree.load('./test/movies.txt')

    assert tree.include?(41)
    assert tree.include?(10)

    assert_equal 6, tree.total_nodes
  end

  def test_health
    tree = BinarySearchTree.new
    tree.insert(45, "movie")
    tree.insert(56, "movie2")
    tree.insert(30, "movie4")
    tree.insert(40, "movie2")
    tree.insert(20, "movie2")

    expected = [[45, 5, 100]]
    actual = tree.health(0)

    assert_equal expected, actual

    expected_1 = [[30, 3, 60], [56, 1, 20]]
    actual_1 = tree.health(1)

    assert_equal expected_1, actual_1
  end

  def test_child_count
    tree = BinarySearchTree.new
    tree.insert(45, "movie")
    tree.insert(40, "movie2")
    tree.insert(30, "movie4")
    tree.insert(42, "movie4")
    expected = 4
    actual = tree.child_count

    assert_equal expected, actual
  end

  def test_leaves
    tree = BinarySearchTree.new
    tree.insert(45, "movie")
    tree.insert(56, "movie2")
    tree.insert(30, "movie4")
    tree.insert(40, "movie2")
    tree.insert(20, "movie2")

    assert_equal 3, tree.leaves
  end

  def test_height
    tree = BinarySearchTree.new
    tree.insert(45, "movie")
    tree.insert(56, "movie2")
    tree.insert(30, "movie4")
    tree.insert(40, "movie2")
    tree.insert(20, "movie2")

    assert_equal 2, tree.height
  end

end
