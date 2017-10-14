require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self.include?(key)
      @count += 1
      if @count > num_buckets
        resize!
      end
      self[key].push(key)
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    self[key].delete(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    dup_store = @store
    @store = Array.new(num_buckets * 2) {Array.new}
    @count = 1
    dup_store.each do |bucket|
      bucket.each do |el|
        self.insert(el)
      end
    end
  end
end
