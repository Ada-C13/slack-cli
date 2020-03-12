require_relative 'test_helper'

describe "Channel" do
  describe ".list_all" do
    it "Can list channels" do
      VCR.use_cassette("list_channels") do
        channels = Channel.list_all
        expect(channels).wont_be_nil
        expect(channels.length > 0).must_equal true
      end
    end
  end
end