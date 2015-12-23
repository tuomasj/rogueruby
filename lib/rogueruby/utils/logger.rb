require 'logger'

class Logger
  def self.method_missing(method_sym, *arguments, &block)
    @logger ||= Logger.init_logger
    if @logger.respond_to? method_sym
      @logger.send(method_sym, arguments)
    else
      @logger.error { "method #{method_sym} is missing." }
    end
  end

  def self.init_logger
    logger = Logger.new(STDOUT)
    logger.level = Logger::INFO
    @output ||= logger
    logger.formatter = proc do |severity, datetime, progname, msg|
       @output << sprintf("[%5.5s] %s\n\r", severity, msg)
    end
    logger
  end

  def self.set_output(param)
    @output = param
  end
end
