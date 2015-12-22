class Section
  attr_reader :id, :x,:y, :width, :height

  def initialize(params = {})
    @id = params.fetch(:id, 0)
    @x = params.fetch(:x, 0)
    @y = params.fetch(:y, 0)
    @width = params.fetch(:width, 0)
    @height = params.fetch(:height, 0)
  end

  def collides?(another_room)
    if another_room == self
      return true
    end
    Collision::collides?(self, another_room)
  end

  def to_json
    { id: id, x: x, y: y, width: width, height: height }
  end

  def to_s
    "Section x: #{x}, y: #{y}, width: #{width}, height: #{height}"
  end

  def self.parse(data)
    new(id: data.fetch(:id, 0), x: data.fetch(:x, 0), y: data.fetch(:y, 0), width: data.fetch(:width, 0), height: data.fetch(:height, 0))
  end

  def to_hash
    { id: id, x: x, y: y, width: width, height: height }
  end
end
