#!/usr/bin/ruby

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
    #@matrix = []
    #matrixSize.times { @matrix << Array.new(matrixSize)}
    @matrix = Hash.new{|j, k| j[k] = []}


    # loop through and set everything to . (empty space)
    for j in 0..@matrixSize
      for k in 0..@matrixSize
        @matrix[j][k] = "."
      end
    end
  
  end
    
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
    puts "Checking if " + shipType + " is sunk.."
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
  
  def placeShip(ship)
    orientation, x, y = ship.orientation, ship.x, ship.y
    puts "Putting ship of size " + String(ship.size) + " at " + String(x) + "," \
      + String(y) + ", " + orientation
    
    # todo - validate input better
    
    if orientation == "r" 
      for j in y..(y + ship.size - 1) 
        @matrix[x][j] = ship.rep
      end
    elsif orientation == "d"
      for j in x..(x + ship.size - 1)
        @matrix[j][y] = ship.rep
      end
    else
      puts "error orienting."
    end
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

class Ship
  def initialize(size, orientation, x, y)
    @size = size
    @orientation = orientation
    @x = x
    @y = y
    
    @rep = ShipSquare
    @name = "Undefined"
  end
  
  attr_reader :size, :orientation, :x, :y, :rep, :name
  
end

#
class AircraftCarrier < Ship
  Size = 5
  def initialize(orientation, x, y)
    super(Size, orientation, x, y)
    @rep = ACSquare
    @name = "Aircraft Carrier"
  end
  
end

class Battleship < Ship
  Size = 4
  def initialize(orientation, x, y)
    super(Size, orientation, x, y)
    @rep = BSquare
    @name = "Battleship"
  end
  
end

class Submarine < Ship
  Size = 3
  def initialize(orientation, x, y)
    super(Size, orientation, x, y)
    @rep = SubSquare
    @name = "Submarine"
  end
  
end

class Cruiser < Ship
  Size = 3
  def initialize(orientation, x, y)
    super(Size, orientation, x, y)
    @rep = CruiserSquare
    @name = "Cruiser"
  end
  
end

class Destroyer < Ship
  Size = 2
  def initialize(orientation, x, y)
    super(Size, orientation, x, y)
    @rep = DestroyerSquare
    @name = "Destroyer"
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
  # @enemyBoard.printEnemyBoard
  @enemyBoard.printBoard
  puts
  7.times { print "= " }
  2.times { puts }
  @playerBoard.printBoard  
end

def getMove
  validMove = false
  while (!validMove)
    print "Enter coords (x y)> "
    coords = gets.chomp
    x, y = coords.split(/ /)
    x, y = Integer(x), Integer(y)
    #TODO: error checking
    validMove = true
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
  print "Aircraft Carrier > "
  line = gets.chomp
  orientation, x, y = line.split(/ /)
  x, y = Integer(x), Integer(y)
  a = AircraftCarrier.new(orientation, x, y)
  @playerBoard.placeShip(a)
  
  print "Battleship > "
  line = gets.chomp
  orientation, x, y = line.split(/ /)
  x, y = Integer(x), Integer(y)
  b = Battleship.new(orientation, x, y)
  @playerBoard.placeShip(b)
  
  print "Submarine > "
  line = gets.chomp
  orientation, x, y = line.split(/ /)
  x, y = Integer(x), Integer(y)
  s = Submarine.new(orientation, x, y)
  @playerBoard.placeShip(s)
  
  print "Cruiser > "
  line = gets.chomp
  orientation, x, y = line.split(/ /)
  x, y = Integer(x), Integer(y)
  c = Cruiser.new(orientation, x, y)
  @playerBoard.placeShip(c)
  
  print "Destroyer > "
  line = gets.chomp
  orientation, x, y = line.split(/ /)
  x, y = Integer(x), Integer(y)
  d = Destroyer.new(orientation, x, y)
  @playerBoard.placeShip(d)
  
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

