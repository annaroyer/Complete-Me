require 'pry'
class Node
  attr_reader   :favorites
  attr_accessor :children,
                :word

  def initialize
    @children          = {}
    @word              = nil
    @favorites         = {}
    @favorites.default = 0
  end

  def append(letters)
    node = Node.new
    @children[letters.shift] = node
    node.push(letters)
  end

  def push(letters)
    if letters.empty?
      return self
    elsif @children.has_key?(letters.first)
      @children[letters.shift].push(letters)
    else
      append(letters)
    end
  end

  def combine
    @children.values.map do |node|
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

  def find_words
    @children.values.map do |node|
      if node.end_of_word? && node.children.empty?
        node.word
      elsif node.end_of_word?
        [node.word, node.find_words]
      else
        node.find_words
      end
    end.flatten
  end

  def iterate(letters)
    if letters.empty?
      return self
    else
      @children[letters.shift].iterate(letters)
    end
  end


  def add_favorite(word)
    @favorites[word] += 1
  end
end
# binding.pry
