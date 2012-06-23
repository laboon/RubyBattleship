
class Board
  
  def initialize
    # note that matrix size 9 = 10 element
    @matrixSize = 9
    @matrix = Hash.new{|j, k| j[k] = []}

    # loop through and set everything to . (empty space)
    for j in 0..@matrixSize
      for k in 0..@matrixSize
        @matrix[j][k] = "."
      end
    end
  
  end
   
  attr_reader :matrixSize
    
  def print_board
    3.times { print " " }
    for j in 0..@matrixSize do
      print j
    end
    puts
  
    rowLetter = '0'
    
    for j in 0..@matrixSize do
      print rowLetter + ": "
      rowLetter.succ!
      for k in 0..@matrixSize do
        print @matrix[j][k]
      end
      puts
    end
  end
  
  def print_enemy_board
    3.times { print " " }
    for j in 0..@matrixSize do
      print j
    end
    puts
    
    #todo - change back to A
    rowLetter = '0'
    
    for j in 0..@matrixSize do
      print rowLetter + ": "
      rowLetter.succ!
      for k in 0..@matrixSize do
        if (@matrix[j][k] != HitSquare \
                             and @matrix[j][k] != MissSquare \
                             and @matrix[j][k] != EmptySquare) 
            print EmptySquare
        else
          print @matrix[j][k]
        end
      end
      puts
    end
  end
  
  def check_sunk(shipType)
    # puts "Checking if " + shipType + " is sunk.."
    for j in 0..@matrixSize
      for k in 0..@matrixSize
        # found a remaining part of the ship
        if @matrix[j][k] == shipType
          return false
        end
      end
    end
    return true  
  end
  
  def get_ship_name(square)
    case square
      when ACSquare
        return "an Aircraft Carrier!"
      when BSquare
        return "a Battleship!"
      when SubSquare
        return "a Submarine!"
      when CruiserSquare
        return "a Cruiser!"
      when DestroyerSquare
        return "a Destroyer!"
      else
        return "a Ship!"
      end
  end
  
  def fire(x, y)
    square = @matrix[x][y]
    case square
    when ACSquare, BSquare, SubSquare, CruiserSquare, DestroyerSquare
      @matrix[x][y] = HitSquare
      puts "HIT!!!!"
      if check_sunk(square)
        puts "You sank " + get_ship_name(square)
      end
    
    when EmptySquare
      puts "MISS!!!!"
      @matrix[x][y] = MissSquare
      
    when HitSquare
      puts "HIT AGAIN!!!!"
    when MissSquare
      puts "MISS AGAIN!!!!"
    end
    
  end
  
  def check_valid_empty(x, y)
    if x < 0 or x > @matrixSize
      return false
    end
    if y < 0 or y > @matrixSize
      return false
    end
    if @matrix[x][y] != EmptySquare
      return false
    end
    return true
  end
  
  def clear_row(letter, row)
    for j in 0..@matrixSize
      if @matrix[row][j] == letter
        @matrix[row][j] = EmptySquare
      end
    end
  end
  
  def clear_column(letter, col)
    for j in 0..@matrixSize
      if @matrix[j][col] == letter
        @matrix[j][col] = EmptySquare
      end
    end
  end
  
  def place_ship(ship)
    orientation, x, y = ship.orientation, ship.x, ship.y
    #puts "Putting ship of size " + String(ship.size) + " at " + String(x) + "," \
    #  + String(y) + ", " + orientation
    
    if orientation == "r" 
      for j in y..(y + ship.size - 1)
        if check_valid_empty(x, j)
          @matrix[x][j] = ship.rep
        else
          clear_row(ship.rep, x)
          return false
        end
      end
    elsif orientation == "d"
      for j in x..(x + ship.size - 1)
        if check_valid_empty(j, y)
          @matrix[j][y] = ship.rep
        else
          clear_column(ship.rep, y)
          return false
        end
      end
    else
      puts "error orienting."
    end
    return true
  end
  
  def defeated?
    for j in 0..@matrixSize
      for k in 0..@matrixSize
        # found a remaining part of the ship
        if @matrix[j][k] != EmptySquare \
                             and @matrix[j][k] != HitSquare \
                             and @matrix[j][k] != MissSquare
          return false
        end
      end
    end
    return true
  end
  
end #class
