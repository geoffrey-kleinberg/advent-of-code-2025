require 'set'

day = "04"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    input = input.map { |i| i.split("") }
    points = []
    for i in 0...input.length
      for j in 0...input[i].length
        if input[i][j] == "@"
          points.append(Complex(i, j))
        end
      end
    end
    neighbors = points.map { |i| points.map { |j| ((i - j).abs <= 1.5) ? 1 : 0 }.sum - 1 }
    return neighbors.count { |i| i < 4 }
end

def part2(input)
    grid = input.map { |i| i.split("") }
    initial = grid.sum { |i| i.count("@") }
    removed = true
    while removed
        removed = false
        newGrid = []
        for i in 0...grid.length
          newGrid[i] = ["."] * grid[i].length
          for j in 0...grid[i].length
            next if grid[i][j] == "."
            neighbors = 0
            for dI in -1..1
              for dJ in -1..1
                next if dI == 0 and dJ == 0
                newI = i + dI
                newJ = j + dJ
                next if newI < 0
                next if newJ < 0
                next if newI >= grid.length
                next if newJ >= grid[j].length
                if grid[newI][newJ] == "@"
                  neighbors += 1
                end
              end
            end
            if neighbors >= 4
              newGrid[i][j] = "@"
            else
              removed = true
            end
          end
        end
        grid = newGrid
    end
    return initial - grid.sum { |i| i.count("@") }
end

# puts part1(data)
puts part2(data)