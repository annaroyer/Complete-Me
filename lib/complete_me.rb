require_relative 'node'

class CompleteMe
  attr_reader :root
  
  def initialize
    @root = Node.new
  end

  def insert(word)
    @root.count += 1
    insert_letters(word)
  end

  def insert_letters(word, current_node = @root)
    # require 'pry'; binding.pry
    letters = word.chars
    until word == ""
      if current_node.value.nil?
        current_node.value = letters[0]
        letters.shift
        word = letters.join
        current_node.child = Node.new
        current_node = current_node.child
        insert_letters(word, current_node)
      else
        current_node.value = letters[0]
        letters.shift
        word = letters.join
        current_node = current_node.child
        insert_letters(word, current_node)
      end
    end
    # require 'pry'; binding.pry
  end
end
