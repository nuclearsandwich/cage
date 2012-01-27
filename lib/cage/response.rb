module Cage
  class Response
    JSON_MIME_REGEX = %r{(?:application/json|application/x-javascript|
                          text/javascript|text/x-javascript|text/x-json)}x
    XML_MIME_REGEX = %r{(?:application/xml|text/xml|application/atom)}x

    def initialize faraday_response
      @faraday_response = faraday_response
    end

    def body
      @body ||= parsed_body
    end

    def parsed_body
      case format_for @faraday_response.headers["content-type"]
      when :json
        MultiJson.decode @faraday_response.body
      when :xml
        Nokogiri::XML::Document.new @faraday_response.body
      end
    end

    def format_for content_type_string
      case content_type_string
      when JSON_MIME_REGEX
        :json
      when XML_MIME_REGEX
        :xml
      end
    end
  end
end
