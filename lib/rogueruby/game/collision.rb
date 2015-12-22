module Collision

  def self.inside?(value, min, max)
    if value >= min and value < max
      return true
    else
      return false
    end
  end

  def self.collides?(room1, room2)
    if (room1.x < (room2.x + room2.width) &&
       (room1.x + room1.width) > room2.x &&
       room1.y < (room2.y + room2.height) &&
       (room1.height + room1.y) > room2.y)
      return true
    else
      return false
    end
  end

end
