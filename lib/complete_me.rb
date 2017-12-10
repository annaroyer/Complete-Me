require_relative 'node'
require 'pry'
class CompleteMe
  attr_reader :root

  def initialize
    @root = Node.new
  end

  def insert(word)
    letters = word.chars
    @root.push(letters)
  end

  def count
    @root.count
  end

  def suggest(substring, node=@root)
    letters = substring.chars
    substring += @root.suggest(letters)
  end

  def populate(dictionary)
    File.readlines(dictionary).each do |word|
      insert(word.chomp)
    end
    # File.readlines(file).count
  end
end
# binding.pry
