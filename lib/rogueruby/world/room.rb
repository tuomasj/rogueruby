# room.rb

class Room
  attr_reader :id, :sections, :x, :y, :entities

  def initialize(params = {})
    @sections = []
    @entities = []
    @id = params.fetch(:id, 0)
    @x = params.fetch(:x, 0)
    @y = params.fetch(:y, 0)
    if params.has_key? :sections
      params[:sections].each do |section|
        push_section( Section.parse(section) )
      end
    end
    if params.has_key? :entities
      params[:entities].each do |entity|
        push_entity( EntityFactory.parse(entity) )
      end
    end
  end

  def width
    min = sections.min {|section| section.width }
    max = sections.max {|section| section.width }
    (max.x + max.width) - min.x
  end

  def height
    min = sections.min {|section| section.height }
    max = sections.max {|section| section.height }
    (max.y + max.height) - min.y
  end

  def set_position(x,y)
    @x = x
    @y = y
  end

  def push_section(new_section)
    sections.each do |section|
      if Collision::collides? section, new_section
        return false
      end
    end
    @sections << new_section
    true
  end

  def push_entity(new_entity)
    @entities << new_entity
  end

  def to_json(*a)
    {
      id: id,
      x: x,
      y: y,
      sections: sections.map {|section| section.to_json },
      entities: entities.map {|entities| entities.to_json }
    }.to_json(*a)
  end

  def self.parse(buf)
    data = JSON.parse(buf)
    create(data)
  end

  def self.create(params)
    Logger.info("Room.create() params: #{params}")

    new(id: params.fetch("id", 0), x: params.fetch("x",0), y: params.fetch("y",0), sections: params.fetch(:sections, []), entities: params.fetch(:entities,[]))
  end

  def to_s
    "Room #{x},#{y} sections: #{sections.map{|s| s.to_s}.join(",")}"
  end

  def to_hash
    {
      id: id,
      x: x,
      y: y,
      sections: sections.map{ |s| s.to_hash }
    }
  end
end
