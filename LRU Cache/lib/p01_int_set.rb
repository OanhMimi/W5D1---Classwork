class MaxIntSet
  attr_accessor :store
  def initialize(max)
    @store = Array.new(max,false)
    @max = max
  end

  def insert(num)
    raise 'Out of bounds' if num > @max || num < 0
    @store[num] = true

  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)

  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % 20].push(num)
  end

  def remove(num)
    @store[num % 20].delete(num)
  end

  def include?(num)
    @store[num % 20].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    sub =  @store[num % @store.length]
    if !sub.include?(num)
      sub << num 
      @count+=1
    end

    if @count > num_buckets
      resize!
    end
  end

  def remove(num)
    sub = @store[num % @store.length]
    if sub.include?(num)
      sub.delete(num)
      @count-=1
    end
  end

  def include?(num)
    @store[num % @store.length].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_set = ResizingIntSet.new(num_buckets*2)
    @store.each do |subArray|
      subArray.each do |ele|
        new_set.insert(ele)
      end
    end
    @store = new_set.store
  end
end
