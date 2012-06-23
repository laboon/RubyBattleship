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


def check_for_win
  
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

def valid_move?(x,y)
  if x >= 0 and x <= @enemyBoard.matrixSize \
    and y >= 0 and x <= @enemyBoard.matrixSize
    
    return true
  else
    return false
  end
end

def get_move
  validMove = false
  while (!validMove)
    print "Enter coords (x y)> "
    coords = gets.chomp
    x, y = coords.split(/ /)
    x, y = Integer(x), Integer(y)
    
    if valid_move?(x, y)
      validMove = true
    else
      puts "Invalid move."
    end
  end
  @enemyBoard.fire(x, y)
  x, y = @enemy.get_move
  @playerBoard.fire(x, y)
  
end

def get_rand_dir
  randVal = rand(2)
  case randVal
  when 0
    return 'r'
  when 1
    return 'd'
  end
end

def place_enemy_ships
  
  shipArr = []
  shipArr << AircraftCarrier.new("r", 1, 0)
  shipArr << Battleship.new("r", 1, 0)
  shipArr << Submarine.new("r", 2, 0)
  shipArr << Cruiser.new("r", 3, 0)
  shipArr << Destroyer.new("r", 4, 0)
  
  shipArr.each do |ship|
    
    works = false
    while (works != true)
      randDir = get_rand_dir
      if (randDir == 'r')
        xLoc = rand(@enemyBoard.matrixSize)
        yLoc = rand(@enemyBoard.matrixSize - ship.size)
      else
        xLoc = rand(@enemyBoard.matrixSize - ship.size)
        yLoc = rand(@enemyBoard.matrixSize)
      end
      ship.orientation = randDir
      ship.x = xLoc
      ship.y = yLoc
      works = @enemyBoard.place_ship(ship)  
    end
  end
    
end

def place_ships
  puts "Enemy placing ships..."
  place_enemy_ships
  puts "done"
  
  puts "Place your ships"
  
  # Aircraft carrier
  
  shipArr = []
  shipArr << AircraftCarrier.new("r", 1, 0)
  shipArr << Battleship.new("r", 1, 0)
  shipArr << Submarine.new("r", 2, 0)
  shipArr << Cruiser.new("r", 3, 0)
  shipArr << Destroyer.new("r", 4, 0)
  
  shipArr.each do |ship|
    
    works = false
    while (works != true)
      print ship.name + " > "
      line = gets.chomp
      orientation, x, y = line.split(/ /)
      ship.orientation = orientation
      ship.x, ship.y = Integer(x), Integer(y)
      works = @playerBoard.place_ship(ship)
      if (not works)
        puts "Invalid location."  
      end
    end
  end
    
end

def print_boards
  2.times { puts }
  @enemyBoard.print_enemy_board
  # @enemyBoard.printBoard
  puts
  7.times { print "= " }
  2.times { puts }
  @playerBoard.print_board  
end


def run_round
  print_boards
  move = get_move
end

# EXECUTION STARTS HERE

@playerBoard, @enemyBoard = Board.new, Board.new
@enemy = Enemy.new

puts "Welcome to Battleship"

place_ships


while (not check_for_win)
  run_round
end

