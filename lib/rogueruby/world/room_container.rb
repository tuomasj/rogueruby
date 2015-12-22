class RoomContainer
  attr_reader :rooms
  def initialize
    @rooms = []
  end
  def init_listeners(dispatcher)
    dispatcher.add_listener(:create, self)
  end

  def push_entity(entity)
    # find a room based on entity coordinates
    room = find_room_by_position(entity.x, entity.y)
    # put entity into that room
    if room
      room.push_entity entity
    end
  end

  def create(params = {})
    Logger.info("RoomContainer.create() params = #{params}")
    if params.fetch(:type, "") == "room"
      Logger.info("Creating room")
      rooms << Room.create(params)
    end
  end

  def find_room_by_position(x,y)
    rooms.each do |room|
      Collision::inside?(x, room.x, (room.x + room.width)) || Collision::inside?(y, room.y, room.y + room.height)
      return room
    end
    return nil
  end
end
