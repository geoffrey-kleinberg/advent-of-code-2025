require 'set'

day = "11"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def getPathsToOut(start, directedGraph)
  if start == "out"
    return 1
  end
  return directedGraph[start].map { |i| getPathsToOut(i, directedGraph) }.sum
end

def part1(input)
    directedGraph = {}
    for line in input
      source, targets = line.split(": ")
      targets = targets.split(" ")
      directedGraph[source] = targets
    end
    return getPathsToOut('you', directedGraph)
end

def getPathsToOutVisitList(start, required, directedGraph, memo)
  if start == "out" and required.length == 0
    return 1
  end
  if start == "out"
    return 0
  end
  if memo[[start, required]]
    return memo[[start, required]]
  end
  
  newReq = required.clone
  if required.include? start
    newReq.delete(start)
  end

  paths = 0
  for toVisit in directedGraph[start]
    paths += getPathsToOutVisitList(toVisit, newReq, directedGraph, memo)
  end

  memo[[start, required]] = paths
  return paths

end

def part2(input)
    directedGraph = {}
    for line in input
      source, targets = line.split(": ")
      targets = targets.split(" ")
      directedGraph[source] = targets
    end
    return getPathsToOutVisitList('svr', ['fft', 'dac'], directedGraph, {})
end

puts part1(data)
puts part2(data)