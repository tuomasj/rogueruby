class World
  attr_reader :rooms, :entities, :current_player
  def initialize(room_klass = RoomContainer, entity_klass = EntityContainer)
    @rooms = room_klass.new
    @entities = entity_klass.new
  end

  def setup_listeners(dispatcher)
    rooms.init_listeners(dispatcher)
    entities.init_listeners(dispatcher)
  end

  def set_current_player(player)
    @current_player = player
  end
end
