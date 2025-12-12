require 'set'

day = "10"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def solveOne(goalState, options)
  queue = ["." * goalState.length]
  seen = Set[queue[0]]
  dists = {
    queue[0] => 0,
  }
  while queue
    current = queue[0]
    queue.delete_at(0)

    if current == goalState
      return dists[current]
    end

    for o in options
      result = current.split("")
      for idx in o
        result[idx] = (result[idx] == ".") ? "#" : "."
      end
      result = result.join
      next if seen.include? result
      queue.append(result)
      seen.add(result)
      dists[result] = dists[current] + 1
    end
  end
end

def part1(input)
    states = input.map { |i| i.split(" ")[0].split("")[1...-1].join }
    options = input.map { |i| i.split(" ")[1...-1].map { |j| j.slice(1, j.length - 2).split(",").map { |k| k.to_i }}}
    total = 0
    for i in 0...states.length
      total += solveOne(states[i], options[i])
    end
    return total
end

def computeRref(matrix, solns)
  rows = matrix.length
  cols = matrix[0].length
  for i in 0...matrix.length
    matrix[i].append(solns[i])
  end
  row = 0
  col = 0
  while row < rows and col < cols
    rowMax = (row...rows).max { |i| matrix[i][col].abs }
    if matrix[rowMax][col] == 0
      col += 1
    else
      temp = matrix[row]
      matrix[row] = matrix[rowMax]
      matrix[rowMax] = temp

      for otherRow in 0...rows
        next if otherRow == row
        p = matrix[otherRow][col]
        for otherCol in 0...(cols + 1)
          matrix[otherRow][otherCol] = matrix[otherRow][otherCol] * matrix[row][col] - p * matrix[row][otherCol]
        end
      end
      row += 1
      col += 1
    end
  end
  return matrix
end

def solveOneLinearAlgebra(joltages, options)
    matrix = []
    len = joltages.length
    for o in options
      row = [0] * len
      for i in o
        row[i] = 1
      end
      matrix.append(row)
    end
    rref = computeRref(matrix.transpose, joltages)
    pivots = rref.map { |i| i.index { |j| j != 0 } }.compact
    freeVars = (0...options.length).map { |i| (pivots.include? i) ? nil : i }.compact
    oVars = freeVars.map { |i| options[i] }
    mins = oVars.map do |i| 
      i.map { |j| joltages[j] }.min
    end 
    choices = [[]]
    for m in mins
      newChoices = []
      for k in 0..m
        for c in choices
          newChoices.append(c + [k])
        end
      end
      choices = newChoices
    end
    puts "evaluating #{choices.size} combinations of free variables"
    best = Float::INFINITY
    bestButtons = []
    for c in choices
      possible = true
      presses = rref.map.with_index do |i, idx|
        if i.all? { |j| j == 0 }
          b = 0
        else
          a = (i.last - freeVars.map.with_index { |j, jdx| c[jdx] * i[j] }.sum) 
          if a % i[pivots[idx]] == 0
            b = a / i[pivots[idx]]
          else
            possible = false
          end
        end
        b
      end
      next if not possible
      next if presses.any? { |i| i < 0 }
      totalPresses = c.sum + presses.sum
      if totalPresses < best
        bestButtons = [c, presses]
      end
      best = [best, totalPresses].min
    end
    # check that every solution is valid
    pressedJoltages = [0] * joltages.length
    for f in 0...freeVars.length
      for k in options[freeVars[f]]
        pressedJoltages[k] += bestButtons[0][f]
      end
    end
    for f in 0...pivots.length
      for k in options[pivots[f]]
        pressedJoltages[k] += bestButtons[1][f]
      end
    end
    if pressedJoltages == joltages
      puts "button presses are right"
    else
      raise "wrong button presses"
    end
    return best
end

def part2(input)
    options = input.map { |i| i.split(" ")[1...-1].map { |j| j.slice(1, j.length - 2).split(",").map { |k| k.to_i }}}
    joltages = input.map { |i| i.split(" ")[-1].split("")[1...-1].join.split(",").map { |j| j.to_i } }
    total = 0
    for i in 0...joltages.length
      current = solveOneLinearAlgebra(joltages[i], options[i])
      total += current
    end
    return total
end

# puts part1(data)
puts part2(data)