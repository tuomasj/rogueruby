class WorldRenderer
  attr_reader :world

  def initialize(ui, world, room_renderer_klass = RoomRenderer)
    @world = world
    @room_renderer = room_renderer_klass.new(ui)
  end

  def center_window(window, player)
    if window && player
      x = window.width / 2 + player.x
      y = window.height / 2 + player.y
      window.set_position(x,y)
    end
  end

  def render(world, player, window)
    center_window(window, player)
    render_list = intersect_rooms(window)
    render_rooms(render_list, window)
  end

  def intersect_rooms(window)
    #world.rooms.rooms.select do |room|

    #  window.overlaps?(room.to_rect)
    #end
    world.rooms.rooms.select { |room| room }
  end

  def render_rooms(rooms, window)
    rooms.each do |room|
      @room_renderer.render(room, window.x, window.y)
    end
  end

end
