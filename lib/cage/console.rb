module Cage
  class Console
    CONNECTION_VARIABLES = [:scheme, :domain, :prefix, :headers]
    HTTP_METHOD_REGEX = /^(?:get|post|put|delete)$/i

    attr_reader :connection, :last_response, *CONNECTION_VARIABLES


    def initialize
      @scheme = "http"
      @domain = "rubygems.org"
      @prefix = "api/v1/gems/"
      @headers = {}
      reinitialize_connection
    end

    def reinitialize_connection
      @connection = Faraday::Connection.new "#{scheme}://#{domain}/#{prefix}",
      :headers => @headers
    end

    def method_missing sym, *args, &block
      if  sym =~ HTTP_METHOD_REGEX
        http sym, *args, &block
      else
        super
      end
    end

    def respond_to? method
      if method =~ HTTP_METHOD_REGEX
        true
      else
        super
      end
    end

    def http method, *args, &block
      @last_response = Cage::Response.new connection.send method, *args, &block
    end

    def set convar, value
      raise ArgumentError, "#{convar} isn't a connection variable" unless
        CONNECTION_VARIABLES.include? convar
      instance_variable_set :"@#{convar}", value
      reinitialize_connection
      value
    end

    def self.start!
      new.pry
    end
  end
end

