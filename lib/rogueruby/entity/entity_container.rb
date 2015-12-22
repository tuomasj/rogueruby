
class EntityContainer

  def init_listeners(dispatcher)
    dispatcher.add_listener(:create, self)
  end

  def create(params = {})
    Logger.info("EntityContainer.create() params = #{params}")
    if params.fetch(:type, "") == "player"
      player = EntityFactory.create(:player, id: params.fetch(:id), x: params.fetch(:x, 0), y: params.fetch(:y, 0))
      world = params.fetch(:world, nil)
      if world && player
        world.set_current_player player
        world.rooms.push_entity player
      end
    end
  end

end
