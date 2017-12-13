require './test/test_helper'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/complete_me'

class CompleteMeTest < Minitest::Test
  def test_it_exists
    completion = CompleteMe.new
    assert_instance_of CompleteMe, completion
  end

  def test_insert_takes_single_word
    completion = CompleteMe.new

    completion.insert('pizza')

    assert_instance_of Node, completion.root.children['p']
    assert_instance_of Node, completion.root.children['p'].children['i']
    assert_instance_of Node, completion.root.children['p'].children['i'].children['z']
    assert_instance_of Node, completion.root.children['p'].children['i'].children['z'].children['z']
    assert_instance_of Node, completion.root.children['p'].children['i'].children['z'].children['z'].children['a']
    assert completion.root.children['p'].children['i'].children['z'].children['z'].children['a'].children.empty?
    assert_nil completion.root.children['i']
  end

  def test_another_way_to_test_it_inserts_a_word
    completion = CompleteMe.new

    completion.insert('pizza')
    completion.insert('pizza')
    assert completion.root.children.has_key?('p')
    assert completion.root.children['p'].children.has_key?('i')
    assert completion.root.children['p'].children['i'].children.has_key?('z')
    assert completion.root.children['p'].children['i'].children['z'].children.has_key?('z')
    assert completion.root.children['p'].children['i'].children['z'].children['z'].children.has_key?('a')
  end

  def test_insert_takes_multiple_words
    completion = CompleteMe.new

    completion.insert('pizza')
    completion.insert('pize')
    completion.insert('kale')
    completion.insert('pizzle')

    assert completion.root.children.has_key?('p')
    assert completion.root.children['p'].children.has_key?('i')
    assert completion.root.children['p'].children['i'].children.has_key?('z')
    assert completion.root.children['p'].children['i'].children['z'].children.has_key?('z')
    assert completion.root.children['p'].children['i'].children['z'].children.has_key?('e')
    assert completion.root.children['p'].children['i'].children['z'].children['z'].children.has_key?('a')
    assert completion.root.children['p'].children['i'].children['z'].children['z'].children.has_key?('l')
    assert completion.root.children['p'].children['i'].children['z'].children['z'].children['l'].children.has_key?('e')
    assert completion.root.children.has_key?('k')
    assert completion.root.children['k'].children.has_key?('a')
    assert completion.root.children['k'].children['a'].children.has_key?('l')
    assert completion.root.children['k'].children['a'].children['l'].children.has_key?('e')
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
    completion = CompleteMe.new

    dictionary = File.read('/usr/share/dict/words')

    completion.populate(dictionary)

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

    word_collection = ['pizzeria', 'pize', 'pizza', 'pizzicato', 'pizzle']
    word_collection.each do |word|
      completion.insert(word)
    end

    completion.select('piz', 'pizzeria')
    completion.select('piz', 'pizzeria')
    completion.select('piz', 'pizzeria')

    completion.select('pi', 'pizza')
    completion.select('pi', 'pizza')
    completion.select('pi', 'pizzicato')

    result1 = completion.suggest('piz')
    result2 = completion.suggest('pi')

    assert_equal 'pizzeria', result1.first
    assert_equal ['pizza', 'pizzicato'], result2.first(2)
  end

  def test_delete_removes_intermediary_words
    completion = CompleteMe.new

    completion.insert('them')
    completion.insert('they')
    completion.insert('themselves')
    completion.insert('the')

    assert_equal ['the', 'them', 'themselves', 'they'], completion.suggest('th').sort

    completion.delete('the')

    assert_nil completion.root.children['t'].children['h'].children['e'].word
    assert_equal ['them', 'themselves', 'they'], completion.suggest('th').sort
  end

  def test_delete_removes_leaf_nodes_and_parents
    completion = CompleteMe.new

    completion.insert('them')
    completion.insert('they')
    completion.insert('themselves')
    completion.insert('the')

    assert_equal ['the', 'them', 'themselves', 'they'], completion.suggest('th').sort

    completion.delete('themselves')

    assert completion.root.children['t'].children['h'].children['e'].children['m'].children.empty?
    assert_equal ['the', 'them', 'they'], completion.suggest('th').sort
  end

  def test_populate_can_insert_all_denver_addresses
    completion = CompleteMe.new

    addresses = []
    CSV.foreach('./data/addresses.csv', headers: true) do |row|
      addresses << row[-1]
    end

    completion.populate_from_csv(addresses)

    assert_equal 308045, completion.count
  end
end
