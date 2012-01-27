require "minitest/autorun"
require "minitest/pride"
require "multi_json"
require "nokogiri"
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
      %w[application/xml text/xml application/atom+xml].each do |xml_content_type|
        subject.format_for(xml_content_type).must_equal :xml
      end
    end
  end

  describe "parses body text for known body types" do
    let(:json_response) do
      m = MiniTest::Mock.new
      m.expect :headers, { "content-type" => "application/json" }
      m.expect :body, File.read("test/rails-gem.json")
    end

    let(:xml_response) do
      m = MiniTest::Mock.new
      m.expect :headers, { "content-type" => "application/atom+xml; charset=UTF-8" }
      m.expect :body, File.read("test/day9.xml")
      m
    end

    let(:html_response) do
      m = MiniTest::Mock.new
      m.expect :headers, { "content-type" => "text/html" }
      m.expect :body, <<-HTML
<html>
  <head><title>Win</title></head>
  <body>Win</body>
</html>
      HTML
      m
    end

    it "parses JSON into a hash" do
      Cage::Response.new(json_response).body.must_be_instance_of Hash
    end

    it "parses XML into a Nokogiri::XML::Document" do
      Cage::Response.new(xml_response).body.must_be_instance_of(
        Nokogiri::XML::Document)
    end

    it "keeps the original body string when the filetype isn't detected" do
      Cage::Response.new(html_response).body.must_be_instance_of String
    end
  end
end

