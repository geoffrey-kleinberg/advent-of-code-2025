require 'set'

day = "01"
# file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    dial = 50
    count = 0
    for line in input
      dir = line.slice(0)
      num = line.slice(1, line.length - 1).to_i
      count += num / 100
      num %= 100
      if dir == "R"
        dial += num
        dial %= 100
      else
        dial -= num
        dial %= 100
      end
      if dial == 0
        count += 1
      end
    end
    return count
end

def part2(input)
    dial = 50
    count = 0
    for line in input
      dir = line.slice(0)
      num = line.slice(1, line.length - 1).to_i
      count += num / 100
      num %= 100
      if dir == "R"
        if dial + num >= 100
          count += 1
        end
        dial += num
        dial %= 100
      else
        if dial != 0 and dial - num <= 0
          count += 1
        end
        dial -= num
        dial %= 100
      end
    end
    return count
end

puts part1(data)
puts part2(data)