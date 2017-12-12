require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class NodeTest < Minitest::Test
  def test_it_adds_favorite_word_to_a_node
    node = Node.new
    node.add_favorite('pizzeria')
    assert_equal 1, node.favorites['pizzeria']
    node.add_favorite('pizzeria')
    node.add_favorite('pizzeria')
    assert_equal 3, node.favorites['pizzeria']
  end

  def test_default_favorites_score_is_0
    node = Node.new

    assert_equal 0, node.favorites['pizza']
  end
end
