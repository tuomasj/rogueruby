module EntityListener
  def bind(type, method, params = [])
    @event_listeners ||= []
    @event_listeners << { type: type, method: method.to_s, params: params }
  end

  def trigger(type, params)
    @event_listeners ||= []
    @event_listeners.each do |event|
      args = event[:params]
      puts "args: #{args.inspect} params: #{params}"
      if event[:type] == type
        send(event[:method], *args)
      end
    end
  end

end

class Entity
  include EntityListener
  attr_reader :id, :x, :y, :type

  def initialize(data = {})

    @id = data.fetch(:id, 0)
    @x = data.fetch(:x, 0)
    @y = data.fetch(:y, 0)
    @type = data.fetch(:type, :entity)
    @event_listeners = []

    bind(:spawn, "spawn", [:room ])
    bind(:exit, "exit")
    bind(:move, "move", [ :room, :x, :y ])
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

class Player < Entity
  def initialize(data)
    super(data)
    @type = :player
  end
end

class EntityFactory
  def self.parse(data)
    if data.fetch(:type) == "player"
      klass = Player
      data.delete :type
    end
    klass.new(data)
  end
end
