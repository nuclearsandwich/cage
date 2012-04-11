module Cage
  class Console
    CONNECTION_VARIABLES = [:scheme, :domain, :prefix, :port, :headers]
    HTTP_METHOD_REGEX = /^(?:get|post|put|delete|head|options|patch)$/i

    attr_reader :connection, :last_response, *CONNECTION_VARIABLES

    def initialize config_file_name = nil
      configure_pry
      read_config_file File.expand_path config_file_name if config_file_name
      default_to_rubygems
      reinitialize_connection
    end

    def reinitialize_connection
      @connection = Faraday.new "#{@scheme}://#{@domain}#{":#{@port}" if @port}/#{@prefix}",
        :headers => @headers do |conn|
          conn.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
          conn.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
          conn.adapter Faraday.default_adapter
          @middleware_builder.call conn unless @middleware_builder.nil?
        end
    end

    # TODO: Use same logic in both method_missing and respond_to?
    def method_missing sym, *args, &block
      case  sym
      when HTTP_METHOD_REGEX
        http sym, *args, &block
      when /^(?:basic|token)_auth/
        connection.send sym, *args, &block
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

    def add_middleware &block
      @middleware_builder = block
      reinitialize_connection
    end

    def http method, *args, &block
      @last_response = Cage::Response.new connection.send method.downcase,
        *args, &block
    end

    def set convar, value
      raise ArgumentError, "#{convar} isn't a connection variable" unless
        CONNECTION_VARIABLES.include? convar
      instance_variable_set :"@#{convar}", value
      reinitialize_connection
      value
    end

    private

    def default_to_rubygems
      @scheme ||= "http"
      unless @domain or @prefix
        @domain = "rubygems.org"
        @prefix = "api/v1/gems/"
      end
      @headers ||= {}
    end

    def read_config_file config_file_name
      if File.exists? config_file_name
        instance_eval File.read(config_file_name), config_file_name
      end
    end

    def configure_pry
      Pry.config.prompt = [
        proc { "[#{domain}:#{last_response && last_response.status}]-> " },
        proc { "[#{domain}]*> " } ]
    end

    def self.start! *args
      new(*args).pry
    end
  end
end

