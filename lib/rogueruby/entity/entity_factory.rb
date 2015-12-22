module EntityListener
  def bind(type, method, params = [])
    @event_listeners ||= []
    @event_listeners << { type: type, method: method.to_s, params: params }
  end

  def trigger(type, params)
    Logger.info("EntityListener.trigger(type: #{type}, params: #{params})")
    @event_listeners ||= []
    @event_listeners.each do |event|
      args = event[:params]
      Logger.info("args: #{args.inspect} params: #{params}")
      if event[:type] == type
        send(event[:method], *args)
      end
    end
  end

end

class Player < Entity
  def initialize(data)
    super(data)
    @type = :player
  end
end

class EntityFactory
  def self.create(type = "", params = {})
    EntityFactory.detect_type(type).new(params)
  end
  def self.parse(data)
    type = data.fetch(:type, "")
    data.delete :type
    EntityFactor.detect_type(type).new(data)
  end

  def self.detect_type(entity_type)
    if entity_type.to_s == "player"
      Player
    else
      raise "Entity type not defined (entity_type: #{entity_type})"
    end
  end
end
