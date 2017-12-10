require_relative 'node'
require 'pry'
class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    letters = word.downcase.chars
    @root.push(letters)
  end

  def count
    @root.count
  end

  def suggest(substring, node=@root)
    letters = substring.downcase.chars
    substring += @root.suggest(letters)
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      insert(word.chomp)
    end
  end
end
binding.pry
