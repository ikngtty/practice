n, m = gets.chomp.split.map(&:to_i)

# 0 → x
# ↓
# y
class PuddleMap
  attr_reader :puddle_points

  # Avoid destructive assignment, but not clear.
  # def self.from_input(line_count)
  #   puddle_points = (0...line_count).map do |y|
  #     gets.chomp.each_char.map.with_index do |chr, x|
  #       { chr: chr, x: x }
  #     end.select do |p|
  #       p[:chr] == '*'
  #     end.map do |p|
  #       { x: p[:x], y: y }
  #     end
  #   end.flatten
  #
  #   self.new(puddle_points)
  # end

  def self.from_input(**args)
    puddle_points = []
    (0...args[:height]).each do |y|
      line = gets.chomp
      (0...args[:width]).each do |x|
        if line[x] == 'W'
          puddle_points.push({ x: x, y: y })
        end
      end
    end

    self.new(puddle_points)
  end

  def initialize(puddle_points)
    @puddle_points = puddle_points
    @puddle_points_hash = puddle_points.map { |p| [p, true] }.to_h
  end

  def get_surrounding_puddles(point)
    x = point[:x]
    y = point[:y]

    [
      { x: x - 1, y: y - 1 },
      { x: x - 1, y: y     },
      { x: x - 1, y: y + 1 },
      { x: x    , y: y - 1 },
      { x: x    , y: y + 1 },
      { x: x + 1, y: y - 1 },
      { x: x + 1, y: y     },
      { x: x + 1, y: y + 1 }
    ].select { |p| @puddle_points_hash[p] }
  end

  def get_puddle_groups
    point_is_grouped = self.puddle_points.map { |p| [p, false] }.to_h

    get_group = lambda do |point, point_is_grouped|
      return [] if point_is_grouped[point]
      point_is_grouped[point] = true

      get_surrounding_puddles(point).reduce([point]) do |group, p|
        group + get_group.call(p, point_is_grouped)
      end
    end

    self.puddle_points.map do |p|
      get_group.call(p, point_is_grouped)
    end.select { |g| g.length > 0 }
  end
end

map = PuddleMap.from_input({ height: n, width: m })
groups = map.get_puddle_groups

# Debug code.
require 'pp'
pp groups

puts groups.length
