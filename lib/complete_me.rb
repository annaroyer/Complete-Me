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
    suggestions = node.to_words
    suggestions << node.word if node.end_of_word?
    suggestions
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      insert(word.chomp)
    end
  end

  def select(substring, word)
    last_letter = iterate(word.chars)
    last_letter.add_weight
  end

  def delete(word, node=@root)
    letters = word.chars
    last_letter = iterate(letters)
    last_letter.word = nil
    # require 'pry'; binding.pry
    if last_letter.children == []
      delete_iteration(word)
    end
  end

  def delete_iteration (word, node=@root)
    # require 'pry'; binding.pry
    until node.word = word
      node = iterate(letters.chop)
      node.children = []
      word = word.chop
    end
  end
end
# binding.pry
