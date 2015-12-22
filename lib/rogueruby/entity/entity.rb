class Entity
  attr_reader :id, :x, :y, :type

  def initialize(data = {})

    @id = data.fetch(:id, 0)
    @x = data.fetch(:x, 0)
    @y = data.fetch(:y, 0)
    @type = data.fetch(:type, :entity)
  end

  def move(room, x, y)
    @x = x
    @y = y
  end

  def spawn(room)
    @room = room
  end

  def exit()
    @room = nil
  end

  def to_hash
    { id: id, x: x, y: y, type: type }
  end

  def to_json
    to_hash
  end
end
