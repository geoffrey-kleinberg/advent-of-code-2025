require 'set'

day = "05"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    emptyIdx = input.index("")
    freshList = input[0...emptyIdx].map { |i| i.split("-").map { |j| j.to_i }}
    ingredients = input[(emptyIdx + 1)..-1].map { |i| i.to_i }
    count = 0
    for i in ingredients
      for f in freshList
        if i >= f[0] and i <= f[1]
          count += 1
          break
        end
      end
    end
    return count
end

def updateRanges(ranges, freshList)
  newRanges = []
  idx = 0
  newStart = nil
  newStop = nil
  for rIdx in 0...ranges.length
    if idx == 2
      newRanges.append(ranges[rIdx])
    end
    if idx == 0
      if freshList[0] > ranges[rIdx][1]
        newRanges.append(ranges[rIdx])
        next
      elsif freshList[0] >= ranges[rIdx][0]
        newStart = ranges[rIdx][0]
      else
        newStart = freshList[0]
      end
      idx = 1
    end
    if idx == 1
      if freshList[1] > ranges[rIdx][1]
        next
      elsif freshList[1] >= ranges[rIdx][0]
        newStop = ranges[rIdx][1]
        newRanges.append([newStart, newStop])
      else
        newStop = freshList[1]
        newRanges.append([newStart, newStop])
        newRanges.append(ranges[rIdx])
      end
      idx = 2
    end
  end

  if idx == 0
    newRanges.append(freshList)
  elsif idx == 1
    newRanges.append([newStart, freshList[1]])
  end

  newRanges
end

def part2(input)
    emptyIdx = input.index("")
    freshList = input[0...emptyIdx].map { |i| i.split("-").map { |j| j.to_i }}
    # freshList = freshList[0..1]
    ranges = [freshList[0]]
    for i in 1...freshList.length
      ranges = updateRanges(ranges, freshList[i])
    end
    return ranges.map { |i| i[1] - i[0] + 1 }.sum
end

puts part1(data)
puts part2(data)