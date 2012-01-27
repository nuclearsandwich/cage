require "minitest/autorun"
require "minitest/pride"
require "cage/response"

describe Cage::Response do
  let(:faraday_response) do
    MiniTest::Mock.new
  end
  subject { Cage::Response.new faraday_response }

  it "is created with a response as the constructor argument" do
    subject.must_be_kind_of Cage::Response
  end

  describe "detects format from content type header" do
    it "detects json" do
      %w[application/json application/x-javascript text/javascript
      text/x-javascript text/x-json].each do |json_content_type|
        subject.format_for(json_content_type).must_equal :json
      end
    end

    it "detects xml" do
      %w[application/xml text/xml].each do |xml_content_type|
        subject.format_for(xml_content_type).must_equal :xml
      end
    end
  end
end

