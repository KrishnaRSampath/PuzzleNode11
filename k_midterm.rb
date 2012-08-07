# Solution to Puzzle Node Problem 11
# 
# Takes in a file (e.g., "complex_cave.txt") and reads in each line.
# The first line is the amount of water (represented by '~') with which to fill the cave.
# The remainder is a diagram of the cave to be filled with water.
#
# Procedure simple_water_fill takes in a cave (represented as an array of arrays,
# with each row of the cave represented as an internal array, and each column
# represented as cells of the same position within any row).  It then fills the cave with
# as much water as specified earlier, according to the following logic:
# 
# 1) If there is empty space below the current cell, it flows down.
# 2) If there is no space below the current cell, but there is in front, it flows forward.
# 3) If both are blocked, it moves back up and to the left until it finds a row that is 
# empty, and then flows forward.
#
# The optional "print_cave" function prints the cave after it has been filled.
#
# Output: The final function ("output"), simply runs through the cave itself, summing the
# total number of water in each column and prints that to the screen in a line.  If any
# water causes an 'overhang' (where a '~' appears above empty spaces), "output" will print
# a '~' to represent a partial fill.



#Initial Definitions:
rows = File.readlines("simple_cave.txt") # Uncomment this line to see the simple example.
#rows = File.readlines("complex_cave.txt") # But be sure to comment this one out if you do!
count = rows[0].to_i    # The first line is how much water to use.
last_row = rows.length-1

cave = []
rows[2..last_row].each do |row|
  cave << row.chomp.split('')
end



# The bulk of the work is handled by this recursive function, which fills the cave.
def simple_water_fill(cave, count, row, col)
  current_cave = cave[row][col]
  cave_below = cave[row+1][col]  #(allows easy check to see if there is a nil value)
  next_cave = cave[row][col+1]
  cave_above = cave[row-1][col]

  return cave if count == 1      # I had it set up to terminate at count == 0, but this 
                                 # produced the dreaded "Off By One" problem in my fill.

  if cave_below == ' ' then   # Flows down if cell below is empty.
    cave[row+1][col] = '~'
    simple_water_fill(cave, count-1, row+1, col)

  elsif cave[row][col+1] == ' ' then # below filled, forward empty
    cave[row][col+1] = '~'
    simple_water_fill(cave, count-1, row, col+1)

  elsif cave[row-1][col] == ' ' #below and forward BOTH filled -- checks up.
    col = col-1 while cave[row-1][col] == ' ' #should go all the way to the back
    simple_water_fill(cave, count, row-1, col)

  else                                        # Both directions are blocked!
    if cave_above then                        # If the cave is a wall above and forward...
      if cave[row-1][col] == '#' && cave[row][col+1] == '#'
        count = 0                             # ...this terminates the procedure.
      else
        simple_water_fill(cave, count, row-1, col)
      end
    end
  end
  
  cave
end

# This procedure prints out the cave as it is.  If called after "simple_water_fill",
# it prints a filled-in cave.
def print_cave(cave)
  cave.each do |row|
    row.each do |cell|
      print cell
    end
    print "\n"
  end
end

# This procedure prints out the single line output to the screen.
def output(cave)
  cave[0].length.times do |col|
    value = 0
    cave.length.times do |row|
      if cave[row][col] == ' ' && value > 0 then
        value = "~"
        break
      end
      if cave[row][col] == '~' then
        value += 1
      end
    end
    print value.to_s + " "
  end
end

# Function Calls:
simple_water_fill(cave, count, 1, 0)
print_cave(cave)
#output(cave)




