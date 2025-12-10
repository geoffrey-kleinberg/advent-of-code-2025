require 'set'

day = "09"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

def part1(input)
    corners = input.map { |i| i.split(",").map { |j| j.to_i } }
    largest = 0
    for i in 0...corners.length
      for j in 0...corners.length
        thisArea = ((corners[i][0] - corners[j][0]).abs + 1) * ((corners[i][1] - corners[j][1]).abs + 1)
        largest = [largest, thisArea].max
      end
    end
    return largest
end

def part2(input)
    corners = input.map { |i| i.split(",").map { |j| j.to_i } }
    verticals = []
    horizontals = []
    for idx in 0...corners.length
      corner = corners[idx]
      nextCorner = corners[(idx + 1) % corners.length]
      if corner[0] == nextCorner[0]
        verticals.append([corner, nextCorner])
      end
      if corner[1] == nextCorner[1]
        horizontals.append([corner, nextCorner])
      end
    end
    largest = 0
    for i in 0...corners.length
      for j in (i + 1)...corners.length
        thisArea = ((corners[i][0] - corners[j][0]).abs + 1) * ((corners[i][1] - corners[j][1]).abs + 1)
        if thisArea < largest
          next
        end

        bottomLeft = [[corners[i][0], corners[j][0]].min, [corners[i][1], corners[j][1]].max]
        bottomRight = [[corners[i][0], corners[j][0]].max, [corners[i][1], corners[j][1]].max]
        topLeft = [[corners[i][0], corners[j][0]].min, [corners[i][1], corners[j][1]].min]
        topRight = [[corners[i][0], corners[j][0]].max, [corners[i][1], corners[j][1]].min]

        valid = true
        leftEdge = [bottomLeft, topLeft]
        rightEdge = [bottomRight, topRight]
        topEdge = [topLeft, topRight]
        bottomEdge = [bottomLeft, bottomRight]
        for h in horizontals
          y = h[0][1]
          
          next if y >= leftEdge[0][1] or y <= leftEdge[1][1]
          xLeft = leftEdge[0][0]
          xRight = rightEdge[0][0]
          lineXMin = [h[0][0], h[1][0]].min
          lineXMax = [h[0][0], h[1][0]].max
          if xLeft < lineXMax and xLeft >= lineXMin
            valid = false
            break
          end
          if xRight <= lineXMax and xRight > lineXMin
            valid = false
            break
          end
        end
        for v in verticals
          x = v[0][0]
          next if x <= bottomEdge[0][0] or x >= bottomEdge[1][0]
          yTop = topEdge[0][1]
          yBottom = bottomEdge[0][1]
          lineYBottom = [v[0][1], v[1][1]].max
          lineYTop = [v[0][1], v[1][1]].min
          if yTop >= lineYTop and yTop < lineYBottom
            valid = false
            break
          end
          if yBottom > lineYTop and yBottom <= lineYBottom
            valid = false
            break
          end
        end
        next if not valid
        largest = [largest, thisArea].max
      end
    end
    return largest
end

# puts part1(data)
puts part2(data)