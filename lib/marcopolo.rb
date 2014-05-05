require "marcopolo/version"
require 'marcopolo/middleware'
require 'marcopolo/rails' if defined?(Rails)

module Marcopolo
  DEFAULT_LOGGER  = Logger.new($stdout)
  DEFAULT_OPTIONS = {
    logger: DEFAULT_LOGGER,
    severity: Logger::Severity::DEBUG
  }

  class << self
    def options
      @@options ||= DEFAULT_OPTIONS.clone
    end

    def log(msg)
      options[:logger].add(options[:severity]) { msg }
    end
  end
end