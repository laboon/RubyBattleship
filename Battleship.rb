#!/usr/bin/ruby

# Referenced files
require 'Ships'
require 'Board'
require 'Enemy'

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

