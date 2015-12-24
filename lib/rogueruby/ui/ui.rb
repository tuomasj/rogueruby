# encoding: UTF-8

require "curses"

class UI

  include Curses

  KEY_LEFT = Curses::KEY_LEFT
  KEY_RIGHT = Curses::KEY_RIGHT
  KEY_UP = Curses::KEY_UP
  KEY_DOWN = Curses::KEY_DOWN

  attr_reader :game_window_width, :game_window_height

  def open

    init_screen
    noecho
    logger_height = 6

    @game_window_width = screen_width
    @game_window_height = screen_height - logger_height
    @game_window = Curses::Window.new(game_window_height,game_window_width,0,0)
    @game_window.idlok(true)
    @game_window.box("|", "-")
    @game_window.scrollok(false)
    @log_window = Curses::Window.new(logger_height, screen_width, game_window_height, 0)
    @log_window.box("|", "-")
    @log_window.scrollok(true)
    @log_window.idlok(true)
    @log_window.timeout = 0
    @log_window.keypad(true)
    hide_cursor

    Logger.set_output(@log_window)

  end

  def start_draw

  end
  def end_draw

  end

  def close
    @game_window.close
    @log_window.close
    show_cursor
    close_screen
  end

  def draw_line(x1, y1, x2, y2, char)

    if x1 == x2 && y1 == y2
      return
    end
    if x1 == x2
      # vertical line
      (y1..y2).each do |j|
        draw_char(x1, j, char)
      end
    elsif y1 == y2
      # horizontal line
      (x1..x2).each do |i|
        draw_char(i, y1, char)
      end
    end
  end

  def fill_rect(x1, y1, x2, y2, char)
    (y1..y2).each do |y|
      (x1..x2).each do |x|
        draw_char(x, y, char)
      end
    end
  end

  def draw_char(x,y, char)

    @game_window.setpos(y,x)
    @game_window.addstr(char)
  end

  def set_cursor_pos(x,y)
    @game_window.setpos(y,x)
  end

  def hide_cursor
    curs_set(0)
  end

  def show_cursor
    curs_set(1)
  end

  def screen_width
    cols
  end

  def screen_height
    lines
  end

  def get_input
    val = @log_window.getch
    return nil unless val
    return KEY_DOWN if val == Curses::KEY_DOWN
    return KEY_UP  if val == Curses::KEY_UP
    return KEY_LEFT if val == Curses::KEY_LEFT
    return KEY_RIGHT if val == Curses::KEY_RIGHT
    val
  end

  def refresh(screen = nil)
    if screen == nil
      @game_window.refresh
      @log_window.refresh
    elsif screen == :game
      @game_window.refresh
    elsif screen == :log
      @log_window.refresh
    end

  end

end

