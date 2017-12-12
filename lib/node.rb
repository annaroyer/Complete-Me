require 'pry'
class Node
  attr_reader   :weight
  attr_accessor :word,
                :symbol,
                :children

  def initialize(letter=nil)
    @symbol   = letter
    @children = []
    @word     = nil
    @weight   = 0
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

  def find_last_nodes
    @children.map do |node|
      if node.end_of_word? && node.children.empty?
        node
      elsif node.end_of_word?
        [node, node.find_last_nodes]
      else
        node.find_last_nodes
      end
    end.flatten
  end

  def sort_suggestions
    find_last_nodes.sort_by do |node|
      0 - node.weight
    end
  end

  def to_words
    sort_suggestions.map do |node|
      node.word
    end
  end

  def add_weight
    @weight += 1
  end
end
# binding.pry
