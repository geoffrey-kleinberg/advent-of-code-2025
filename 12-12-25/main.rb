require 'set'

day = "12"
file_name = "12-#{day}-25/sampleIn.txt"
file_name = "12-#{day}-25/input.txt"

data = File.read(file_name).split("\n").map { |i| i.rstrip }

# NOTES: 
# 2 of type 0 take a 4x4 space (2 empty spaces)
# 
#   AAA. 
#   ABAB
#   ABAB
#   .BBB
#   
# 2 of type 2 take 3x4 space (0 empty spaces)
# 
#   AAA
#   AAB
#   ABB
#   BBB
#   
# 2 of type 3 take 3x4 space (2 empty spaces)
#   
#   AA.
#   BAA
#   BBA
#   .BB
#   
# 1 each of type 4 and 5 take 3x5 space (1 empty space)
# 
#   A.A
#   AAA
#   AAB
#   BBB
#   BBB
#   
# 2 of type 5 take 3x5 space (1 empty)
# 
#   AAA
#   AAA
#   A.B
#   BBB
#   BBB
#   
# 1 of anything is a 3x3 block
# Now we just have to figure out how to pack rectangles, which is much easier than these shapes

def doBoxesFitInSize(size, boxes)
  # try to pack all the 3 by x into size
  
  vertHeight = 3 * boxes[[3, 3]] + 4 * boxes[[3, 4]] + 5 * boxes[[3, 5]]

  columns = vertHeight / size[0]

  size[1] -= (3 * (columns + 1))

  return boxes[[4, 4]] < (size[0] / 4) * (size[1] / 4)
end

def isValid(size, numbers)
  boxes = {}
  # type 0
  boxes[[4, 4]] = numbers[0] / 2
  boxes[[3, 3]] = numbers[0] % 2

  # type 1
  boxes[[3, 3]] += numbers[1]

  # type 2
  boxes[[3, 4]] = numbers[2] / 2
  boxes[[3, 3]] += numbers[2] % 2

  # type 3
  boxes[[3, 4]] += numbers[3] / 2
  boxes[[3, 3]] += numbers[3] % 2

  # types 4 and 5
  combos = [numbers[4], numbers[5]].min
  boxes[[3, 5]] = combos
  numbers[4] -= combos
  numbers[5] -= combos
  
  boxes[[3, 5]] += numbers[5] / 2

  boxes[[3, 3]] += numbers[5] % 2
  boxes[[3, 3]] += numbers[4]
  return doBoxesFitInSize(size, boxes)
end

def part1(input)
    regions = input[30..-1]
    valid = 0
    for r in regions
      size, numbers = r.split(": ")
      size = size.split("x").map { |i| i.to_i }
      numbers = numbers.split(" ").map { |i| i.to_i }
      # this is such cheese but I guess it works
      valid += isValid(size, numbers) ? 1 : 0
    end
    return valid
end

def part2(input)
    return "Free star!"
end

puts part1(data)
puts part2(data)