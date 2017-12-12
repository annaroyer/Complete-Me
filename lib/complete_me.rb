require_relative 'node'
require 'pry'
class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    letters = word.chars
    node = @root.push(letters)
    node.word = word
  end

  def count
    @root.count
  end

  def iterate(letters, node=@root)
    until letters.empty?
      node = node.children[letters.shift]
    end
    node
  end

  def suggest(substring)
    substring_end = iterate(substring.chars)
    suggestions = substring_end.find_words
    suggestions << substring_end.word if substring_end.end_of_word?
    suggestions.sort_by do |word|
      0 - substring_end.favorites[word]
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
 # binding.pry
