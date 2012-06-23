
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
