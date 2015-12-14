# room.rb

module Collision

  def self.inside?(value, min, max)
    if min >= value and max < value
      return true
    else
      return false
    end
  end

  def self.collides?(room1, room2)
    if (room1.x < room2.x + room2.width &&
       room1.x + room1.width > room2.x &&
       room1.y < room2.y + room2.height &&
       room1.height + room1.y > room2.y)
      return true
    else
      return false
    end
  end

end

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
    #TODO is inside a section?
    @entities << new_entity
    new_entity.trigger(:spawn, self) 
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
    sections = data["sections"].map{ |s| s.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}   } if data.has_key? "sections"
    entities = data["entities"].map{ |s| s.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}   } if data.has_key? "entities"
    new(id: data.fetch("id", 0), x: data.fetch("x",0), y: data.fetch("y",0), sections: sections || [], entities: entities || [])
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
