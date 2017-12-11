require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'node'

class NodeTest < Minitest::Test
  def test_node_weight_starts_at_zero
    node = Node.new

    assert_equal 0, node.weight
  end

  def test_add_weight_increases_node_weight_by_one
    node = Node.new

    node.add_weight

    assert_equal 1, node.weight

    node.add_weight
    node.add_weight

    assert_equal 3, node.weight
  end

end
