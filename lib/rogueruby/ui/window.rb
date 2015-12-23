class Window
  attr_reader :x, :y, :width, :height, :top, :left, :bottom, :right

  def initialize(x,y,width,height)
    Logger::info("Window.initialize(x:#{x}, y:#{y}, width: #{width}, height: #{height}")
    set_size(width, height)
    set_position(0,0)
  end

  def set_size(w,h)
    Logger::info("Window.set_size(w:#{w}, h:#{h})")
    @width = w
    @height = h
  end

  def set_position(x,y)
    Logger::info("Window.set_position(x:#{x}, y:#{y})")
    @top = x
    @left = y
    @right = @left + width
    @bottom = @top + height
  end

  def x
    @left
  end

  def y
    @top
  end

  def overlaps?(rect)
    Logger::info("Window.overlaps?(rect: #{rect})")
    Collision.collides? rect, self
  end
end
