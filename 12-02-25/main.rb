require 'set'

day = "02"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    nums = input[0].split(',').map { |i| i.split('-').map { |j| j.to_i }}
    # print nums
    numLengths = nums.map { |i| i.map { |j| Math.log10(j).floor + 1 } }
    # puts
    truncatedRanges = nums.map.with_index do |i, idx| 
      res = []
      if numLengths[idx][0] % 2 == 1
        res[0] = 10 ** (numLengths[idx][0])
      else
        res[0] = i[0]
      end
      if numLengths[idx][1] % 2 == 1
        res[1] = 10 ** (numLengths[idx][1] - 1)
      else
        res[1] = i[1]
      end
      res
    end
    # print numLengths
    # puts
    # print truncatedRanges
    # puts
    groupSums = truncatedRanges.map.with_index { |i, idx|
        if i[0] > i[1]
          0
        else
          exp = (numLengths[idx][0] % 2) ? (numLengths[idx][1]) : (numLengths[idx][0])
          divisor = 10 ** (exp / 2) + 1
          ((i[0] / divisor.to_f).ceil..(i[1] / divisor)).sum * divisor
        end
    }
    # print groupSums
    # puts
    return groupSums.sum
end

def part2(input)
    nums = input[0].split(',').map { |i| i.split('-').map { |j| j.to_i }}
    splitRanges = []
    splitLengths = []
    numLengths = nums.map { |i| i.map { |j| Math.log10(j).floor + 1 } }
    for i in 0...nums.length
      if numLengths[i][0] == numLengths[i][1]
        splitRanges.append(nums[i])
        splitLengths.append(numLengths[i][0])
      else
        splitPoint = 10 ** (numLengths[i][0])
        splitRanges.append([nums[i][0], splitPoint - 1])
        splitLengths.append(numLengths[i][0])
        splitRanges.append([splitPoint, nums[i][1]])
        splitLengths.append(numLengths[i][1])
      end
    end
    # print splitRanges
    # puts
    # print splitLengths
    # puts
    divisors = {
        1 => [],
        2 => [11],
        3 => [111],
        4 => [101],
        5 => [11111],
        6 => [1001, 10101],
        7 => [1111111],
        8 => [10001],
        9 => [1001001],
        10 => [100001, 101010101]
    }
    doubleCounts = {
        6 => [111111],
        10 => [1111111111]
    }
    groupSums = splitRanges.map.with_index do |i, idx|
        divs = divisors[splitLengths[idx]]
        tot = divs.map { |divisor| (((i[0] / divisor.to_f).ceil..(i[1] / divisor)).sum * divisor) }.sum
        if doubleCounts[splitLengths[idx]]
          div = doubleCounts[splitLengths[idx]][0]
          tot -= (((i[0] / div.to_f).ceil..(i[1] / div)).sum * div)
        end
        tot
    end
    # print groupSums
    # puts
    return groupSums.sum
end

# puts part1(data)
puts part2(data)