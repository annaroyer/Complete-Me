require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require_relative 'node'

class NodeTest < Minitest::Test
  def test_node_has_26_potential_new_letters
    node = Node.new

  end

  def test_node_can_take_a_letter_string_and_choose_the_associated_link
  end

end
