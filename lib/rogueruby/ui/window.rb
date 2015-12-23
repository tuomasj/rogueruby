class Window
  attr_reader :x, :y, :width, :height, :top, :left, :bottom, :right

  def initialize(x,y,width,height)
    set_size(width, height)
    set_position(0,0)
  end

  def set_size(w,h)
    @width = w
    @height = h
  end

  def set_position(x,y)
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
    Collision.collides? rect, self
  end
end
