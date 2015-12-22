require_relative "../test_helper.rb"

require 'rogueruby/ui/window'
require 'rogueruby/game/collision'

class TestWindow < Minitest::Test

  def test_window_has_all_necessary_methods
    all_necessary_methods = [:x, :y, :width, :height]
    window = Window.new(0,0,60,30)
    all_necessary_methods.each do |method|
      assert_respond_to window, method, "method '#{method}' is missing"
    end
  end

  def test_two_overlapping_rects_return_true
    window = Window.new(0,0,60,30)
    rect = stub(x: 5, y:3, width: 10, height: 10)
    assert_equal true, window.overlaps?(rect), "intersect should return true since rect intersects window"
  end

  def test_two_rects_that_do_not_touch_each_other_return_false
    window = Window.new(0,0,10,10)
    window.set_position(10,10)
    rect = stub(x: 0, y:4, width: 10, height: 10)
    assert_equal false, window.overlaps?(rect), "intersect should return true since rect intersects window"
  end
end
