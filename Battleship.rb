#!/usr/bin/ruby

# Referenced files
require 'Ships'
# require 'Board'

# Constants
EmptySquare = "."
ShipSquare ="+"
ACSquare = "A"
BSquare = "B"
SubSquare = "S"
CruiserSquare = "C"
DestroyerSquare = "D"
MissSquare = "O"
HitSquare = "X"


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

class Enemy
  
  def getMove
    x, y = rand(10), rand(10)
    return x, y
  end
end

def checkForWin
  
  playerDefeated = @playerBoard.defeated?
  enemyDefeated = @enemyBoard.defeated?
  if (playerDefeated and enemyDefeated)
    puts "Mutual destruction!"
    return true
  elsif playerDefeated
    puts "Enemy won!  Player lost!"
    return true
  elsif enemyDefeated
    puts "Player won!  Enemy lost!"
    return true
  else
    return false
  end
  
end

def printBoards
  2.times { puts }
  @enemyBoard.printEnemyBoard
  # @enemyBoard.printBoard
  puts
  7.times { print "= " }
  2.times { puts }
  @playerBoard.printBoard  
end

def validMove?(x,y)
  if x >= 0 and x <= @enemyBoard.matrixSize \
    and y >= 0 and x <= @enemyBoard.matrixSize
    
    return true
  else
    return false
  end
end

def getMove
  validMove = false
  while (!validMove)
    print "Enter coords (x y)> "
    coords = gets.chomp
    x, y = coords.split(/ /)
    x, y = Integer(x), Integer(y)
    
    if validMove?(x, y)
      validMove = true
    else
      puts "Invalid move."
    end
  end
  @enemyBoard.fire(x, y)
  x, y = @enemy.getMove
  @playerBoard.fire(x, y)
  
end

def placeEnemyShips
  a = AircraftCarrier.new("r", 0, 0)
  b = Battleship.new("r", 1, 0)
  s = Submarine.new("r", 2, 0)
  c = Cruiser.new("r", 3, 0)
  d = Destroyer.new("r", 4, 0)
  @enemyBoard.placeShip(a)
  @enemyBoard.placeShip(b)
  @enemyBoard.placeShip(s)
  @enemyBoard.placeShip(c)
  @enemyBoard.placeShip(d)
end

def placeShips
  puts "Enemy placing ships..."
  placeEnemyShips
  puts "done"
  
  puts "Place your ships"
  
  # Aircraft carrier
  
  validSpot = false
  while validSpot == false
    print "Aircraft Carrier > "
    line = gets.chomp
    orientation, x, y = line.split(/ /)
    x, y = Integer(x), Integer(y)
    a = AircraftCarrier.new(orientation, x, y)
    validSpot = @playerBoard.placeShip(a)
    if not validSpot
      puts "Invalid location."  
    end
  end
  
  validSpot = false
  while validSpot == false
    print "Battleship > "
    line = gets.chomp
    orientation, x, y = line.split(/ /)
    x, y = Integer(x), Integer(y)
    b = Battleship.new(orientation, x, y)
    validSpot = @playerBoard.placeShip(b)
    if not validSpot
      puts "Invalid location."  
    end
  end
  
  validSpot = false
  while validSpot == false
    print "Submarine > "
    line = gets.chomp
    orientation, x, y = line.split(/ /)
    x, y = Integer(x), Integer(y)
    s = Submarine.new(orientation, x, y)
    validSpot = @playerBoard.placeShip(s)
    if not validSpot
      puts "Invalid location."  
    end
  end
  
  validSpot = false
  while validSpot == false
    print "Cruiser > "
    line = gets.chomp
    orientation, x, y = line.split(/ /)
    x, y = Integer(x), Integer(y)
    c = Cruiser.new(orientation, x, y)
    validSpot = @playerBoard.placeShip(c)
    if not validSpot
      puts "Invalid location."  
    end
  end
  
  validSpot = false
  while validSpot == false
    print "Destroyer > "
    line = gets.chomp
    orientation, x, y = line.split(/ /)
    x, y = Integer(x), Integer(y)
    d = Destroyer.new(orientation, x, y)
    validSpot = @playerBoard.placeShip(d)
    if not validSpot
      puts "Invalid location."  
    end
  end
  
end

def runRound
  printBoards
  move = getMove
end

# EXECUTION STARTS HERE

@playerBoard, @enemyBoard = Board.new, Board.new
@enemy = Enemy.new

puts "Welcome to Battleship"

placeShips


while (not checkForWin)
  runRound
end

