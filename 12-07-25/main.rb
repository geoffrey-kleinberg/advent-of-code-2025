require 'set'

day = "07"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    input = input.map { |i| i.split("") }
    startCol = input[0].index("S")
    rowAbove = [false] * input[0].length
    rowAbove[startCol] = true
    splits = 0
    for idx in 1...input.length
      thisRow = []
      for jdx in 0...input[idx].length
        if rowAbove[jdx]
          if input[idx][jdx] == "."
            thisRow[jdx] = true
          else
            splits += 1
            thisRow[jdx - 1] = true
            thisRow[jdx + 1] = true
          end
        end
      end
      rowAbove = thisRow
    end
    return splits
end

def timelinesBelow(entryIdx, remaining, memo)
    if remaining.length == 1
        return 1
    end
    if memo[[entryIdx, remaining.length]]
      return memo[[entryIdx, remaining.length]]
    end
    rowAbove = [false] * remaining[0].length
    rowAbove[entryIdx] = true
    for idx in 1...remaining.length
        thisRow = []
        for jdx in 0...remaining[idx].length
            if rowAbove[jdx]
                if remaining[idx][jdx] == "."
                    thisRow[jdx] = true
                else
                    ans = timelinesBelow(jdx - 1, remaining[idx..-1], memo) + timelinesBelow(jdx + 1, remaining[idx..-1], memo)
                    memo[[entryIdx, remaining.length]] = ans
                    return ans
                end
            end
        end
        rowAbove = thisRow
    end
    return 1
end

def part2(input)
    input = input.map { |i| i.split("") }
    startCol = input[0].index("S")
    return timelinesBelow(startCol, input, {})
end

# puts part1(data)
puts part2(data)