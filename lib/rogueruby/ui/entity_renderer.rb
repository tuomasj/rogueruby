class EntityRenderer

  def initialize(ui)
    @ui = ui
  end

  def render_entity(room, entity, offset_x, offset_y)
    draw_entity(entity.x + offset_x, entity.y + offset_y, entity.type)
  end

  def draw_entity(x,y,type)
    @ui.draw_char(x,y,"@")
  end
end
