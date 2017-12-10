require 'pry'
class Node
  attr_reader :symbol,
              :children

  def initialize(letter=nil)
    @symbol = letter
    @children = []
    @last = false
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
      @last = true
    elsif has_child?(letters.first)
      find_child(letters.shift).push(letters)
    else
      append(letters)
    end
  end

  def last_letter?
    @last
  end

  def combine
    @children.map do |node|
      [node, node.combine]
    end.flatten
  end

  def count
    combine.count do |node|
      node.last_letter?
    end
  end

  def suggest(letters)
    if letters.empty?
      complete
    else
      node = find_child(letters.shift)
      node.suggest(letters)
    end
  end

  def complete
    @children.map do |node|
      [node.symbol, node.complete]
    end.flatten.compact
  end
end
binding.pry
