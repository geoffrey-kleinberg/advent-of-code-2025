require 'set'

day = "06"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i }

def part1(input)
    numbers = input[0...-1].map { |i| i.split(" ").map { |j| j.to_i } }
    symbols = input[-1].split(" ")
    total = 0
    for idx in 0...symbols.length
      if symbols[idx] == '*'
        total += numbers.map { |i| i[idx] }.inject(1) { |prod, i| prod * i }
      else
        total += numbers.map { |i| i[idx] }.sum
      end
    end
    return total
end

def part2(input)
    numbers = input[0...-1].map { |i| i.split("")}.transpose.map { |i| i.join('').to_i }
    numbersJoined = []
    idx = 0
    lastIdx = 0
    while idx < numbers.length
      if numbers[idx] == 0
        numbersJoined.append(numbers[lastIdx...idx])
        lastIdx = idx + 1
      end
      idx += 1
    end
    numbersJoined.append(numbers[lastIdx...idx])
    symbols = input[-1].split(" ")
    total = 0
    for idx in 0...symbols.length
      if symbols[idx] == '*'
        total += numbersJoined[idx].inject(1) { |prod, i| prod * i }
      else
        total += numbersJoined[idx].sum
      end
    end
    return total
end

puts part1(data)
puts part2(data)