require 'set'

day = "03"
file_name = "12-#{day}-25/sampleIn.txt"
# file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    matrix = input.map { |i| i.split("").map { |j| j.to_i } }
    tens = matrix.map { |i| i[0..-2].max }
    idxs = matrix.map.with_index { |i, idx| i.index(tens[idx]) }
    ones = matrix.map.with_index { |i, idx| i[(idxs[idx] + 1)..-1].max }
    return tens.sum * 10 + ones.sum
end

def part2(input)
    digits = 12
    matrix = input.map { |i| i.split("").map { |j| j.to_i } }
    idxs = [-1] * matrix.length
    sum = 0
    for dig in 0...digits
      best = matrix.map.with_index { |i, idx| i[(idxs[idx] + 1)..(dig - digits)].max }
      addToIdxs = matrix.map.with_index { |i, idx| i[(idxs[idx] + 1)..(dig - digits)].index(best[idx]) + 1 }
      idxs = idxs.map.with_index { |i, idx| i + addToIdxs[idx]}
      sum += best.sum * (10 ** (digits - dig - 1))
    end
    return sum
end

def part2oneLine(input)
    return (1..12).inject([[-1] * input.length]) { |prevs, i| prevs.append((0...input.length).inject([]) { |idxs, j| idxs.append(input.map { |i| i.split("").map { |j| j.to_i } }.map.with_index { |k, idx| k[(prevs[-1][idx] + 1)..-1].index(k[(prevs[-1][idx] + 1)..(i - 1 - 12)].max) + prevs[-1][idx] + 1 }[j])})}.map.with_index { |i, idx| (10 ** (12 - idx)) * input.map { |i| i.split("").map { |j| j.to_i } }.map.with_index { |j, jdx| (i[jdx] < 0) ? 0 : (j[i[jdx]]) }.sum }.sum
end

puts part1(data)
puts part2(data)
puts part2oneLine(data)