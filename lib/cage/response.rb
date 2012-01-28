module Cage
  class Response
    attr_reader :faraday_response

    def initialize faraday_response
      @faraday_response = faraday_response
    end

    def body
      @faraday_response.body
    end

    def status
      @faraday_response.status
    end

    def headers
      @faraday_response.headers
    end

    def url
      @faraday_response.env[:url].to_s
    end

    def inspect
      <<-PRETTY

Status: #{status}

Headers:
#{headers.map { |k, v| "  #{k}: #{v}" }.join "\n"}

Body:
  #{body}

#<Cage::Response:(#{url})>
      PRETTY
    end
  end
end
