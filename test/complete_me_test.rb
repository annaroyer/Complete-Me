require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/complete_me.rb'

class CompleteMeTest < Minitest::Test
  def test_insert_adds_word
    completion = CompleteMe.new

    completion.insert("pizza")
    completion.insert("pizzeria")

    require 'pry'; binding.pry

  end

end
