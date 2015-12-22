require 'json'

class CentralDispatcher
  include Listenable

  attr_reader :world

  def initialize(world)
    @world = world
  end

  def incoming(json_string)
    Logger.info("CentralDispatcher.incoming(#{json_string})")
    begin
      obj = CentralDispatcher.symbolize(JSON.parse(json_string))
      if obj.has_key? :method
        method = obj.fetch(:method)
        obj.delete(:method)
        dispatch(method, obj)
      end
    rescue JSON::ParserError => e
      Logger.error( 'unable to parse JSON' )
      Logger.error(e.to_s)
      false
    end
  end

  def dispatch(method, params = {})
    Logger.info("CentralDispatcher.dispatch(:#{method}, params: #{params})")
    notify_listeners method.to_sym, params.merge!(world: world)
  end

  private

  def self.symbolize(obj)
    return obj.reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = symbolize(v) }
    end if obj.is_a? Hash

    return obj.reduce([]) do |memo, v|
      memo << symbolize(v); memo
    end if obj.is_a? Array

    obj
  end

end
