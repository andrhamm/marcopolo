require "marcopolo/version"
require 'marcopolo/middleware'
require 'marcopolo/rails' if defined?(Rails)
require 'uuid'
require 'logger'

module Marcopolo
  DEFAULT_LOGGER  = Logger.new($stdout)
  DEFAULT_OPTIONS = {
    logger: DEFAULT_LOGGER,
    severity: Logger::Severity::DEBUG,
    filter: Proc.new {|request| true }
  }

  class Listener
    def initialize()

    end
  end

  class << self
    def options
      @@options ||= DEFAULT_OPTIONS.clone
    end

    def log(msg)
      options[:logger].add(options[:severity]) { msg }
    end

    def allow?(request)
      options[:filter].call(request)
    end

    def capture(stream=[], opts={}, &block)
      raise unless block_given?
      max = opts.key?(:max) ? opts[:max] : 10

      listener_id = Marcopolo.add_listener stream
      yield
      true
    ensure
      Marcopolo.remove_listener listener_id
    end

    def add_listener(listener)
      guid = UUID.new.generate
      listeners[guid] = listener
      guid
    end

    def remove_listener(guid)
      listeners.delete guid
    end

    def listeners
      @@listeners ||= {}
    end
  end
end