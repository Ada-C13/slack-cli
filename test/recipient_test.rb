require_relative "test_helper"

describe "Recipient class" do
  before do
    VCR.use_cassette("recipient_get") do
      @response = Recipient.get("users.list")
    end
  end

  it "Can response to user calls" do
    expect(@response).must_be_kind_of HTTParty::Response
  end
end

describe "Recipient class" do
  before do
    VCR.use_cassette("recipient_get") do
      @response = Recipient.get("channels.list")
    end
  end

  it "Can response to channel calls" do
    expect(@response).must_be_kind_of HTTParty::Response
  end
end
