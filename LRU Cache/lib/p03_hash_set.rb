class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @store[key.hash % @store.length] << key
    @count += 1
    if @count > @store.length
      self.resize!
    end
  end

  def include?(key)
    sub = @store[key.hash % @store.length]
    sub.include?(key)
  end

  def remove(key)
    sub = @store[key.hash % @store.length]
    if sub.include?(key)
      sub.delete(key) 
      @count -= 1
    end
   
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_arr = @store.dup
    @count = 0
    @store = Array.new(num_buckets*2) { Array.new }
    old_arr.each do |subArray|
      subArray.each do |ele|
        self.insert(ele)
      end
    end
  end
end
