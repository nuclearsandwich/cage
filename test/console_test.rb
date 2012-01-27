require "faraday"
require "minitest/autorun"
require "minitest/pride"
require "cage/console"

describe Cage::Console do
  subject { Cage::Console.new }

  it "responds to http methods" do
    [:get, :GET, :post, :POST, :put, :PUT, :delete, :DELETE].each do |method|
      subject.must_respond_to method
    end
  end

  it "allows you to set connection variables" do
    subject.set :scheme, "http"
    subject.instance_variable_get(:@scheme).must_equal "http"

    subject.set :domain, "ultrasaurus.com"
    subject.instance_variable_get(:@domain).must_equal "ultrasaurus.com"

    subject.set :prefix, "blog"
    subject.instance_variable_get(:@prefix).must_equal "blog"

    subject.set :headers, "X-Awesome" => true
    subject.instance_variable_get(:@headers).must_equal "X-Awesome" => true
  end

  it "will raise an error if you set a nonsensical variable" do
    proc { subject.set :foobar, "baz" }.must_raise ArgumentError
  end
end

