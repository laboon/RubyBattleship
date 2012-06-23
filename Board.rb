
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
    
  def printBoard
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
  
  def printEnemyBoard
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
  
  def checkSunk(shipType)
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
  
  def fire(x, y)
    square = @matrix[x][y]
    case square
    when ACSquare
      @matrix[x][y] = HitSquare
      puts "HIT!!!!"
      if checkSunk(ACSquare)
        puts "You sunk an Aircraft Carrier!"
      end
    when BSquare
      @matrix[x][y] = HitSquare
      puts "HIT!!!!"
      if checkSunk(BSquare)
        puts "You sunk a Battleship!"
      end
    when SubSquare
      @matrix[x][y] = HitSquare
      puts "HIT!!!!"
      if checkSunk(SubSquare)
        puts "You sunk a Submarine!"
      end
    when CruiserSquare
      @matrix[x][y] = HitSquare
      puts "HIT!!!!"
      if checkSunk(CruiserSquare)
        puts "You sunk a Cruiser!"
      end
    when DestroyerSquare
      @matrix[x][y] = HitSquare
      puts "HIT!!!!"
      if checkSunk(DestroyerSquare)
        puts "You sunk a Destroyer!"
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
  
  def checkValidEmpty(x, y)
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
  
  def clearRow(letter, row)
    for j in 0..@matrixSize
      if @matrix[row][j] == letter
        @matrix[row][j] = EmptySquare
      end
    end
  end
  
  def clearColumn(letter, col)
    for j in 0..@matrixSize
      if @matrix[j][col] == letter
        @matrix[j][col] = EmptySquare
      end
    end
  end
  
  def placeShip(ship)
    orientation, x, y = ship.orientation, ship.x, ship.y
    #puts "Putting ship of size " + String(ship.size) + " at " + String(x) + "," \
    #  + String(y) + ", " + orientation
    
    if orientation == "r" 
      for j in y..(y + ship.size - 1)
        if checkValidEmpty(x, j)
          @matrix[x][j] = ship.rep
        else
          clearRow(ship.rep, x)
          return false
        end
      end
    elsif orientation == "d"
      for j in x..(x + ship.size - 1)
        if checkValidEmpty(j, y)
          @matrix[j][y] = ship.rep
        else
          clearColumn(ship.rep, y)
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
