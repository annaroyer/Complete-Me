require_relative 'node'
require 'csv'
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

  def suggest(substring)
    substring_last_node = @root.iterate(substring.chars)
    suggestions = substring_last_node.find_words
    suggestions << substring_last_node.word if substring_last_node.end_of_word?
    suggestions.sort_by do |word|
      0 - substring_last_node.favorites[word]
    end
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      insert(word.chomp)
    end
  end

  def select(substring, word)
    substring_last_node = @root.iterate(substring.chars)
    substring_last_node.add_favorite(word)
  end


  def delete(word)
    last_letter = @root.iterate(word.chars)
    last_letter.word = nil
    trim(word.chars) if last_letter.children.empty?
  end

  def trim(letters, node=@root)
    until node.count == 0
      node = node.children[letters.shift]
    end
    node.children = {}
  end

end
