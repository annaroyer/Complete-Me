require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_insert_takes_single_word
    completion = CompleteMe.new

    completion.insert('pizza')

    assert_instance_of CompleteMe, completion
    assert_equal 'p', completion.root.children['p'].symbol
    assert_equal 'i', completion.root.children['p'].children['i'].symbol
    assert_equal 'z', completion.root.children['p'].children['i'].children['z'].symbol
    assert_equal 'z', completion.root.children['p'].children['i'].children['z'].children['z'].symbol
    assert_equal 'a', completion.root.children['p'].children['i'].children['z'].children['z'].children['a'].symbol
    assert completion.root.children['p'].children['i'].children['z'].children['z'].children['a'].children.empty?
    assert_nil completion.root.children['i']

    # completion.insert('pizza')
    # assert_instance_of CompleteMe, completion
    # assert_equal 'p', completion.root.children[0].symbol
    # assert_equal 'i', completion.root.children[0].children[0].symbol
    # assert_equal 'z', completion.root.children[0].children[0].children[0].symbol
    # assert_equal 'z', completion.root.children[0].children[0].children[0].children[0].symbol
    # assert_equal 'a', completion.root.children[0].children[0].children[0].children[0].children[0].symbol
    # assert_nil completion.root.children[0].children[0].children[0].children[0].children[0].children[0]
    # assert_nil completion.root.children[1]
  end

  def test_insert_takes_multiple_words
    completion = CompleteMe.new

    completion.insert('pizza')
    completion.insert('pize')
    completion.insert('kale')
    completion.insert('pizzle')

    # require 'pry'; binding.pry

    assert_instance_of CompleteMe, completion
    assert_equal 'p', completion.root.children[0].symbol
    assert_equal 'i', completion.root.children[0].children[0].symbol
    assert_equal 'z', completion.root.children[0].children[0].children[0].symbol
    assert_equal 'z', completion.root.children[0].children[0].children[0].children[0].symbol
    assert_equal 'a', completion.root.children[0].children[0].children[0].children[0].children[0].symbol
    assert_equal 'e', completion.root.children[0].children[0].children[0].children[1].symbol
    assert_nil completion.root.children[0].children[0].children[0].children[1].children[0]
    assert_equal 'l', completion.root.children[0].children[0].children[0].children[0].children[1].symbol
    assert_equal 'e', completion.root.children[0].children[0].children[0].children[0].children[1].children[0].symbol
    assert_nil completion.root.children[0].children[0].children[0].children[0].children[1].children[0].children[0]
    assert_equal 'k', completion.root.children[1].symbol
    assert_equal 'a', completion.root.children[1].children[0].symbol
    assert_equal 'l', completion.root.children[1].children[0].children[0].symbol
    assert_equal 'e', completion.root.children[1].children[0].children[0].children[0].symbol
    assert_nil completion.root.children[1].children[0].children[0].children[0].children[0]
    # require 'pry'; binding.pry
  end

  def test_count_counts_words
    completion = CompleteMe.new

    assert_equal 0, completion.count

    completion.insert('pizza')
    completion.insert('pize')
    completion.insert('kale')
    completion.insert('pizzle')

    assert_equal 4, completion.count

    completion.insert('')

    assert_equal 4, completion.count

    completion.insert('the')
    completion.insert('them')

    assert_equal 6, completion.count
  end

  def test_suggest_outputs_appropriate_words
    completion = CompleteMe.new

    completion.insert('pizza')
    completion.insert('pize')
    completion.insert('kale')
    completion.insert('pizzle')

    assert_equal ['pize', 'pizza', 'pizzle'], completion.suggest('piz').sort
  end

  def test_suggest_outputs_correct_words_with_nested_words
    completion = CompleteMe.new

    completion.insert('pie')
    completion.insert('piece')

    assert_equal ['pie', 'piece'], completion.suggest('pi').sort
  end

  def test_populate_inserts_all_dictionary_words
    skip
    completion = CompleteMe.new

    dictionary = File.read('/usr/share/dict/words')

    completion.populate(dictionary)
    # require 'pry'; binding.pry
    assert_equal 235886, completion.count
  end

  def test_select_influences_suggest_return_value
    completion = CompleteMe.new

    word_collection = ['pize', 'pizza', 'pizzeria', 'pizzicato', 'pizzle']
    word_collection.each do |word|
      completion.insert(word)
    end

    assert_equal word_collection, completion.suggest('piz')

    completion.select('piz', 'pizzeria')

    result = completion.suggest('piz')

    assert_equal 'pizzeria', result.first
  end

  def test_it_suggests_words_specific_to_substring_selections
    completion = CompleteMe.new

    word_collection = ["pizzeria", "pize", "pizza", "pizzicato", "pizzle"]
    word_collection.each do |word|
      completion.insert(word)
    end

    completion.select("piz", "pizzeria")
    completion.select("piz", "pizzeria")
    completion.select("piz", "pizzeria")

    completion.select("pi", "pizza")
    completion.select("pi", "pizza")
    completion.select("pi", "pizzicato")

    result1 = completion.suggest('piz')
    result2 = completion.suggest('pi')

    assert_equal 'pizzeria', result1.first
    assert_equal ['pizza', 'pizzicato'], result2.first(2)
  end
end
