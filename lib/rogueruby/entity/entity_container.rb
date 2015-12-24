
class EntityContainer

  attr_reader :entities

  def initialize
    @entities = []
  end

  def init_listeners(dispatcher)
    dispatcher.add_listener(:create, self)
    dispatcher.add_listener(:move, self)
  end

  def create(params = {})
    if params.fetch(:type, "") == "player"
      player = EntityFactory.create(:player, id: params.fetch(:id), x: params.fetch(:x, 0), y: params.fetch(:y, 0))
      world = params.fetch(:world, nil)
      if world && player
        world.set_current_player player
        world.rooms.push_entity player
        entities.push player
      end
    end
  end

  def move(params = {})
    id = params.fetch(:entity_id, -1)
    direction = params.fetch(:direction, "")
    if direction != ""
      filtered = entities.select { |entity| entity.id == id }
      filtered.each do |entity|
        entity.move(direction.upcase)
      end
    end
  end

end
