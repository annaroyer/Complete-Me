require 'pry'
class Node
  attr_reader :symbol,
              :children
  attr_accessor :word

  def initialize(letter=nil)
    @symbol = letter
    @children = []
    @word = nil
  end

  def has_child?(letter)
    @children.any? do |node|
      node.symbol == letter
    end
  end

  def find_child(letter)
    @children.find do |node|
      node.symbol == letter
    end
  end

  def append(letters)
    node = Node.new(letters.shift)
    @children << node
    node.push(letters)
  end

  def push(letters)
    if letters.empty?
      return self
    elsif has_child?(letters.first)
      find_child(letters.shift).push(letters)
    else
      append(letters)
    end
  end

  def combine
    @children.map do |node|
      [node, node.combine]
    end.flatten
  end

  def count
    combine.count do |node|
      node.end_of_word?
    end
  end

  def end_of_word?
    @word
  end

  def words
    @children.map do |node|
      if node.end_of_word? && node.children.empty?
        node.word
      elsif node.end_of_word?
        [node.word, node.words]
      else
      node.words
      end
    end.flatten
  end

end
# binding.pry
