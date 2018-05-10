require 'minitest/autorun'
require 'minitest/pride'
require './lib/node.rb'

class NodeTest < Minitest::Test

  def test_if_it_exists
    node = Node.new(88, 'movie')

    assert_instance_of Node, node
  end

  def test_pass_down
    node = Node.new(50, 'movie')

    assert_equal 50, node.score
    assert_equal 0, node.depth

    node.pass_down(70, 'movie2')

    assert_nil node.left_node
    assert_equal 70, node.right_node.score

    node.pass_down(60, 'movie3')

    assert_nil node.right_node.right_node
    assert_equal 60, node.right_node.left_node.score
    assert_equal 2, node.right_node.left_node.depth

    node.pass_down(20, 'movie4')
  end

end
