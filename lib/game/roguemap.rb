# roguemap.rb
require 'json'
require './entity_factory'
require './room'
require './room_renderer'
require './entity_renderer'
require "./ui"

class DebugUI
  attr_reader :width, :height
  def start_draw(w,h)
    puts "DebugUI.start_draw(#{w}, #{h})"
    @width = w
    @height = h
    @buf = Array.new(width * height)
    @buf.fill(0)
    @count =1
  end

  def end_draw
    puts "DebugUI.end_draw"
    (0..height).each do |y|
      line = ""
      (0..width).each do |x|
        if @buf[y*width+x] != 0
          line += "#{@buf[y*width+x]}"
        else
          line += " "
        end
      end
      puts line
    end
  end

  def draw_room(x,y,w,h)
    puts "DebugUI.draw_room(#{x}, #{y}, #{w}, #{h})"
    (0..h-1).each do |j|
      (0..w-1).each do |i|
        @buf[(y+j)*width+(x+i)] = @count
      end
    end
    @count = @count +1
  end
end

str = '{"x":0,"y":0,"sections":[{"x":0,"y":0,"width":5,"height":3},{"x":5,"y":2,"width":5,"height":3}]}
'
room = Room.new
room.push_section Section.new(id: 0, x: 3, y: 2, width: 7, height: 9)
room.push_section Section.new(id: 1, x: 10, y: 10, width: 18,height: 10)
room.push_section Section.new(id: 2, x: 34, y: 4, width: 25,height: 15)
room.push_section Section.new(id: 3, x: 28, y: 12, width: 6,height: 1)
room.push_entity Player.new(id: 0, x: 4, y: 3)
# room = Room.parse('{"x":0,"y":0,"sections":[{"x":3,"y":2,"width":7,"height":9},{"x":10,"y":10,"width":18,"height":10},{"x":34,"y":4,"width":25,"height":15},{"x":28,"y":12,"width":6,"height":1}]}')
room_render = RoomRenderer.new(UI)
room_render.render(room, 0, 0)
puts room.to_json
UI.new.wait_input
