# new test

def simple_water_fill(cave, count, row, col)
  current_cave = cave[row][col]
  cave_below = cave[row+1][col]  #(allows easy check to see if there is a nil value)
  next_cave = cave[row][col+1]
  cave_above = cave[row-1][col]
#  puts
#  puts 'Count is currently '+count.to_s
  return cave if count == 1

  if cave_below && cave_below == ' ' then
#    puts "Below is empty.  Now I'm flowing down!"
    cave[row+1][col] = '~'
    simple_water_fill(cave, count-1, row+1, col)

  elsif next_cave && cave[row][col+1] == ' ' then # below filled, forward empty
#    puts 'Forward is empty.  Flowing onward!'
    cave[row][col+1] = '~'
    simple_water_fill(cave, count-1, row, col+1)
  elsif cave_above && cave[row-1][col] == ' ' #below and forward BOTH filled -- try above me
    #FLOW UPWARDS
    col = col-1 while cave[row-1][col] == ' ' #should go all the way to the back
    simple_water_fill(cave, count, row-1, col)
  else
#    puts "Everywhere is blocked. Go up one?"
    if cave_above then
      if cave[row-1][col] == '#' && cave[row][col+1] == '#'
#        puts 'You are blocked!!!'
        count = 0
      else
        simple_water_fill(cave, count, row-1, col)
      end
    end
  end
  
  cave
end

def print_cave(cave)
  cave.each do |row|
    row.each do |cell|
      print cell
    end
    print "\n"
  end
end


rows = File.readlines("complex_cave.txt")
count = rows[0].to_i
last_row = rows.length-1
cave = []
rows[2..last_row].each do |row|
  cave << row.chomp.split('')
end
numcols = cave[0].length

simple_water_fill(cave, count, 1, 0)
print_cave(cave)


numcols.times do |col|
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



