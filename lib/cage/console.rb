module Cage
  class Console
    CONNECTION_VARIABLES = [:scheme, :domain, :prefix, :headers]

    attr_reader :connection, *CONNECTION_VARIABLES

    def initialize
      reinitialize_connection
    end

    def reinitialize_connection
      @connection = Faraday::Connection.new "#{domain}/#{prefix}"
    end

    def method_missing sym, *args, &block
      if  sym =~ /^(?:get|post|put|delete)$/i
        http sym, *args, &block
      else
        super
      end
    end

    end

    def http method, *args, &block
      connection.send method, *args, &block
    end

    def set convar, value
      instance_variable_set :"@#{convar}", value
      reinitialize_connection
      value
    end

    def self.start!
      new.pry
    end
  end
end

