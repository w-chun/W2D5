class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    next_node = @next
    prev_node = @prev
    next_node.prev = prev_node
    prev_node.next = next_node
    @next = nil
    @prev = nil
    self
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    temp_node = Node.new(key, val)
    @tail.prev.next = temp_node
    temp_node.prev = @tail.prev
    @tail.prev = temp_node
    temp_node.next = @tail
    temp_node
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    node_remove = nil
    self.each do |node|
      node_remove = node if node.key == key
    end
    if node_remove
      node_remove.remove
    end
  end

  def each(&blk)
    temp_node = @head
    until temp_node.next == @tail || temp_node == nil
      temp_node = temp_node.next
      blk.call(temp_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` includedl

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
