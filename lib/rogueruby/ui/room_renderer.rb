
class RoomRenderer
  attr_reader :ui

  WALL_TILE = "#"
  FLOOR_TILE = "."

  def initialize(ui)
    @ui = ui
    @entity_renderer = EntityRenderer.new(@ui)
  end

  def render(room, offset_x, offset_y)
    ofs_x = 0
    ofs_y = 0
    ui.start_draw
    # draw room walls
    room.sections.each do |section|
      render_wall(section, ofs_x, ofs_y)
    end
    # draw room floors
    room.sections.each do |section|
      render_floor(section, ofs_x, ofs_y)
    end

    room.entities.each do |entity|
      @entity_renderer.render_entity(room, entity, ofs_x, ofs_y)
    end
    ui.end_draw
  end

  def render_floor(section, offset_x, offset_y)
    x1 = section.x
    x2 = section.x + section.width - 1
    y1 = section.y
    y2 = section.y + section.height - 1
    ui.fill_rect(x1,y1,x2,y2, FLOOR_TILE)
  end

  def render_wall(section, offset_x, offset_y)
    x1 = section.x - 1
    x2 = section.x + section.width
    y1 = section.y - 1
    y2 = section.y + section.height

    ui.draw_line(x1,y1,x2,y1, WALL_TILE)
    ui.draw_line(x1,y2,x2,y2, WALL_TILE)
    ui.draw_line(x1,y1,x1,y2, WALL_TILE)
    ui.draw_line(x2,y1,x2,y2, WALL_TILE)

  end
end
