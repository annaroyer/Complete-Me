class Node
  attr_accessor :value,
                :child,
                :count

  def initialize(value = nil)
    @value    = value
    @child    = nil
    @count    = 0
  end

  def insert(word)
    # require 'pry'; binding.pry
    letters = word.chars
    if @value.nil?
      @value = letters[0]
      word = letters.shift
      insert(word)
    else @child = Node.new
      child.value = letters[0]
      word = letters.shift
      insert(word)
    end
  end
end
