require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node'

class NodeTest < Minitest::Test
  def test_it_can_count_all_words_built_on_itself
    root = Node.new
    node1 = root.push('pizza'.chars)
    node1.word = 'pizza'
    node2 = root.push('pizzeria'.chars)
    node2.word = 'pizzeria'
    node3 = root.push('pize'.chars)
    node3.word = 'pize'
    node4 = root.push('hello'.chars)
    node4.word = 'hello'

    node5 = root.children['p'].children['i'].children['z']
    node6 = root.children['p'].children['i'].children['z'].children['z']

    assert_equal 4, root.count
    assert_equal 3, node5.count
    assert_equal 2, node6.count
  end

  def test_it_can_return_whether_it_is_the_end_of_a_node
    root = Node.new
    node1 = root.push('pizza'.chars)
    node1.word = 'pizza'
    node2 = root.push('pizzeria'.chars)
    node2.word = 'pizzeria'
    node3 = root.children['p'].children['i']

    assert node1.end_of_word?
    assert node2.end_of_word?
    refute root.end_of_word?
    refute node3.end_of_word?
  end

  def test_it_can_find_all_words_built_on_itself
    root = Node.new

    root = Node.new
    node1 = root.push('pizza'.chars)
    node1.word = 'pizza'
    node2 = root.push('pizzeria'.chars)
    node2.word = 'pizzeria'
    node3 = root.push('pize'.chars)
    node3.word = 'pize'
    node4 = root.push('hello'.chars)
    node4.word = 'hello'
    node5 = root.children['p'].children['i'].children['z'].children['z']
    node6 = root.children['h']

    expected1 = ['pizza', 'pizzeria', 'pize', 'hello']
    expected2 = ['pizza', 'pizzeria']
    expected3 = ['hello']

    assert_equal expected1, root.find_words
    assert_equal expected2, node5.find_words
    assert_equal expected3, node6.find_words
  end

  def test_it_can_iterate_through_a_path_of_nodes
    root = Node.new
    root.push('pizza'.chars)
    node = root.iterate('piz'.chars)

    assert node.children.has_key?('z')
    assert node.children['z'].children.has_key?('a')
  end

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
