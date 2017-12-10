require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_insert_takes_single_word
    completion = CompleteMe.new

    completion.insert('pizza')

    # require 'pry'; binding.pry

    completion.insert('pizzeria')

    # require 'pry': binding.pry

    completion.insert('kale')

    require 'pry'; binding.pry
  end


end
