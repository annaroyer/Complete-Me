require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/node.rb'

class NodeTest < Minitest::Test
  def test_insert_adds_word
    node = Node.new

    node.insert("pizza")

  end

end
