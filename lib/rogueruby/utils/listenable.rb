module Listenable

  def listeners()
    @listeners ||= {}
  end

  def add_listener(method, listener)
    if listeners.has_key? method.to_sym
      listeners[method.to_sym] << listener
    else
      listeners[method.to_sym] = [listener]
    end
  end

  def remove_listener(method, listener)
    if listeners.has_key? method.to_sym
      listeners[method.to_sym].delete listener
    end
  end

  def notify_listeners(method, *args)
    if listeners.has_key? method.to_sym
      listeners[method.to_sym].each do |listener|
        if listener.respond_to? method.to_s
          listener.__send__ method.to_s, *args
        end
      end
    end
  end

end
