require 'set'

day = "08"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def l2Norm(a1, a2)
    return a1.map.with_index { |i, idx| (a1[idx] - a2[idx]) * (a1[idx] - a2[idx]) }.sum
end

def part1(input)
    locations = input.map { |i| i.split(",").map { |j| j.to_i } }
    distMap = {}
    distList = []
    for i in 0...locations.length
      for j in (i+1)...locations.length
        next if i == j
        dist = l2Norm(locations[i], locations[j])
        distList.append(dist)
        distMap[dist] = [i, j]
      end
    end
    islands = (0...locations.length).map { |i| [i].to_set }
    countToConnect = 1000
    for d in distList.min(countToConnect)
      toConnect = distMap[d]
      i1 = nil
      i2 = nil
      for j in 0...islands.length
        if islands[j].include? toConnect[0]
          i1 = j
        end
        if islands[j].include? toConnect[1]
          i2 = j
        end
      end
      next if i1 == i2
      first, last = (i1 < i2) ? [i1, i2] : [i2, i1]
      islands[first] = islands[first] + islands[last]
      islands.delete_at(last)
    end
    return islands.map { |i| i.size }.max(3).inject(1) { |prod, i| prod * i}
end

def part2(input)
    locations = input.map { |i| i.split(",").map { |j| j.to_i } }
    distMap = {}
    distList = []
    for i in 0...locations.length
      for j in (i+1)...locations.length
        next if i == j
        dist = l2Norm(locations[i], locations[j])
        distList.append(dist)
        distMap[dist] = [i, j]
      end
    end
    islands = (0...locations.length).map { |i| [i].to_set }
    islandMap = {}
    (0...locations.length).each { |i| islandMap[i] = i }
    islandCount = locations.length
    while islandCount > 1
      toConnect = distMap[distList.min]
      distList.delete(distList.min)
      i1 = islandMap[toConnect[0]]
      i2 = islandMap[toConnect[1]]
      next if i1 == i2
      islandCount -= 1
      islands[i1] = islands[i1] + islands[i2]
      for j in islands[i2]
        islandMap[j] = i1
      end
      islands[i2] = nil
    end
    return locations[toConnect[0]][0] * locations[toConnect[1]][0]
end

# puts part1(data)
puts part2(data)