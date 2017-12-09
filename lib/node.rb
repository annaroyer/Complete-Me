class Node
  def initialize(letter)
    @symbol = letter
    @child = nil
    @next = nil
  end

  def next_node(letters)
    if @symbol == letters.first
      return @child
    else
      return @next
    end
  end

  def append(letters)
    if @symbol == letters.shift
      @child = Node.new(letters.first)
    else
      @next = Node.new(letters.first)
    end
  end

  def push(letters)
    if letters.empty?
      return
    elsif next_node(letters).nil?
      if @symbol == letters.first
        append(letters)
        @child.push(letters)
      else
        append(letters)
        @next.push(letters)
      end
    else
      letters.shift
      push(letters)
    end
  end
end
