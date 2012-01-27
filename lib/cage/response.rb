module Cage
  class Response
    JSON_MIME_REGEX = %r{(?:application/json|application/x-javascript|
                          text/javascript|text/x-javascript|text/x-json)}x
    XML_MIME_REGEX = %r{(?:application/xml|text/xml)}x

    def initialize faraday_response
      @faraday_response = faraday_response
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
