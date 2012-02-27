require "minitest/autorun"
require "cage/response"

describe Cage::Response do
  let(:faraday_response) do
    MiniTest::Mock.new
  end
  subject { Cage::Response.new faraday_response }

  it "is created with a response as the constructor argument" do
    subject.must_be_kind_of Cage::Response
  end
end

