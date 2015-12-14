require "curses"

class UI

  include Curses

  def open
    noecho
    init_screen
  end

  def start_draw

  end
  def end_draw

  end
  
  def close
    close_screen
  end

  def draw_line(x1, y1, x2, y2, char)
    if x1 == x2 && y1 == y2
      return
    end
    if x1 == x2
      # vertical line
      (y1..y2).each do |j|
        setpos(j, x1)
        addstr(char)
      end
    elsif y1 == y2
      # horizontal line
      (x1..x2).each do |i|
        setpos(y1, i)
        addstr(char)
      end
    end
  end

  def fill_rect(x1, y1, x2, y2, char)
    (y1..y2).each do |y|
      (x1..x2).each do |x|
        setpos(y,x)
        addstr(char)
      end
    end
  end

  def draw_char(x,y, char)
    setpos(y,x)
    addstr(char)
  end

  def wait_input
    setpos(0,0)
    addstr(" ")
    getch 
  end
end

