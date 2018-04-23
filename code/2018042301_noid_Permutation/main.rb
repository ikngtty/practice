class Array
  def remove_at(pos)
    dup = self.dup
    dup.delete_at(pos)
    dup
  end
end

# Simple.
def permutations1(array)
  return [[]] if array.empty?

  (recursive = lambda do |array|
    return [array] if array.length == 1

    array.map.with_index do |item, i|
      recursive.call(array.remove_at(i)).map do |perm|
        [item] + perm
      end
    end.flatten(1)
  end).call(array)
end

# Improve performance: Don't store permutation's snapshots.
def permutations2(array, &block)
  return [[]] if array.empty?

  used = Array.new(array.length, false)
  current_perm = Array.new(array.length)

  enum = Enumerator.new do |y|
    (recursive = lambda do |current_index|
      if current_index == array.length - 1
        available_pos = used.find_index { |used| !used }
        current_perm[available_pos] = array[current_index]
        y << current_perm.dup
      else
        (0...array.length).each do |pos|
          next if used[pos]
          current_perm[pos] = array[current_index]
          used[pos] = true
          recursive.call(current_index + 1)
          used[pos] = false
        end
      end
    end).call(0)
  end

  if block_given?
    enum.each(&block)
  else
    enum
  end
end

# Test
array = (1..3).to_a
p permutations1(array)
p permutations2(array).to_a
permutations2(array) { |perm| p perm }
p array.permutation.to_a

def time
  start = Time.now
  yield
  Time.now - start
end

array = (1..9).to_a
p time { permutations1(array) }       # around 2.7s
p time { permutations2(array).to_a }  # around 1.0s
p time { array.permutation.to_a }     # around 0.2s
