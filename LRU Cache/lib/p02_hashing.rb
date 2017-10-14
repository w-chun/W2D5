class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.join("").to_i.hash
  end
end

class String
  def hash
    self.chars.map(&:ord).join("").to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    data = ""
    self.each { |key, value| data += key.to_s + value.to_s }
    data.chars.sort.join.hash
  end
end
