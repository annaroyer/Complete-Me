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
    node.find_words
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      insert(word.chomp)
    end
  end
end
# binding.pry
