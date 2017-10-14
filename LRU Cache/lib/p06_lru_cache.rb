require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map.include?(key) ? update_node!(@map[key]).val : calc!(key).val
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if count == @max
    @map[key] = @store.append(key, @prc.call(key))
    @map[key]
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    updated_node = node.remove
    @map[updated_node.key] = @store.append(updated_node.key, updated_node.val)
    updated_node
  end

  def eject!
    @map.delete(@store.first.key)
    @store.first.remove
  end
end
