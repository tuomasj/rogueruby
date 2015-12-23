# encoding: UTF-8

require "curses"

class UI

  include Curses

  attr_reader :game_window_width, :game_window_height

  def open
    noecho
    init_screen
    logger_height = 6
    @game_window_width = screen_width
    @game_window_height = screen_height - logger_height
    Logger::info("UI.open() @game_window_width: #{@game_window_width}, @game_window_height: #{@game_window_height}")
    @game_window = Curses::Window.new(game_window_height,game_window_width,0,0)
    @game_window.box("|", "-")
    @log_window = Curses::Window.new(logger_height, screen_width, game_window_height, 0)
    @log_window.box("|", "-")
    @log_window.scrollok(true)
    @log_window.idlok(true)
    Logger::set_output(@log_window)

  end

  def start_draw

  end
  def end_draw

  end

  def close
    @game_window.close
    close_screen
  end

  def draw_line(x1, y1, x2, y2, char)

    if x1 == x2 && y1 == y2
      return
    end
    if x1 == x2
      # vertical line
      (y1..y2).each do |j|
        @game_window.setpos(j, x1)
        @game_window.addstr(char)
      end
    elsif y1 == y2
      # horizontal line
      (x1..x2).each do |i|
        @game_window.setpos(y1, i)
        @game_window.addstr(char)
      end
    end
  end

  def fill_rect(x1, y1, x2, y2, char)
    (y1..y2).each do |y|
      (x1..x2).each do |x|
        @game_window.setpos(y,x)
        @game_window.addstr(char)
      end
    end
  end

  def draw_char(x,y, char)

    @game_window.setpos(y,x)
    @game_window.addstr(char)
  end

  def wait_input
@log_window.refresh
@game_window.refresh

    hide_cursor
    @game_window.getch
    show_cursor
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


end

