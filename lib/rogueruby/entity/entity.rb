class Entity
  attr_reader :id, :x, :y, :type

  DIRECTIONS = {
    "LEFT": { dx: -1, dy: 0 },
    "RIGHT": { dx: 1, dy: 0 },
    "UP": { dx: 0, dy: -1 },
    "DOWN": { dx: 0, dy: 1 }
  }

  def initialize(data = {})

    @id = data.fetch(:id, 0)
    @x = data.fetch(:x, 0)
    @y = data.fetch(:y, 0)
    @type = data.fetch(:type, :entity)
  end

  def move(direction)
    dir = direction.to_sym
    if DIRECTIONS.has_key?(dir)
      new_x = @x + DIRECTIONS[dir][:dx]
      new_y = @y + DIRECTIONS[dir][:dy]
      #TODO collision detection
      @x = new_x
      @y = new_y
    end
  end

  def to_hash
    { id: id, x: x, y: y, type: type }
  end

  def to_json
    to_hash
  end
end
