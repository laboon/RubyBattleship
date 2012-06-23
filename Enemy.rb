

class Enemy
  # Constants
  
  HuntMode = 'H'
  TargetMode = 'T'

  def initialize
    @currentState = HuntMode
    @lastX = -1
    @lastY = -1
    
  end
  
  def give_result(x, y, result)
    @lastX = x
    @lastY = y
  end
  
  def get_move
    if @currentState == HuntMode
      # TODO: implement "checkerboard" hunting
      # TODO: only fire shots at untested locations
      x, y = rand(10), rand(10)
    elsif @currentState == TargetMode
      # TODO: targeting code
      x, y = rand(10), rand(10)
    end
    return x, y
  end
end
