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
