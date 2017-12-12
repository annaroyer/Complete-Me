require_relative 'node'
require 'pry'
class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    node = @root.push(word.chars)
    node.word = word
  end

  def count
    @root.count
  end

  def iterate(letters, node=@root)
    until letters.empty?
      node = node.find_child(letters.shift)
    end
    node
  end

  def suggest(substring)
    node = iterate(substring.chars)
    suggestions = node.find_words
    suggestions << node.word if node.end_of_word?
    suggestions.sort_by do |word|
      0 - node.favorites[word]
    end
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      insert(word.chomp)
    end
  end

  def select(substring, word)
    substring_last_node = iterate(substring.chars)
    substring_last_node.add_favorite(word)
  end
end
 binding.pry
