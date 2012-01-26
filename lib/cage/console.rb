module Cage
  class Console
    CONNECTION_VARIABLES = [:scheme, :domain, :prefix, :headers]

    attr_reader :connection, :last_response, *CONNECTION_VARIABLES

    def initialize
      @scheme = "http"
      @domain = "duckduckgo.com"
      @prefix = "?q="
      reinitialize_connection
    end

    def reinitialize_connection
      @connection = Faraday::Connection.new "#{scheme}://#{domain}/#{prefix}"
    end

    def method_missing sym, *args, &block
      if  sym =~ /^(?:get|post|put|delete)$/i
        http sym, *args, &block
      else
        super
      end
    end

    def print_response
      ap [ last_response.status, last_response.headers, last_response.body ]
    end

    def http method, *args, &block
      @last_response = connection.send method, *args, &block
      print_response
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

