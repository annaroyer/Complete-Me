require_relative 'node'

class CompleteMe
  attr_reader :root

  def initialize
    @root = nil
  end

  def insert(word)
    letters = word.downcase.chars
    if @root.nil?
      @root = Node.new(letters.first)
    end
    @root.push(letters)
  end
end
