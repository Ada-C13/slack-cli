require_relative 'test_helper.rb'


describe "Channel" do
  it "can initialize channel with slack id" do
    VCR.use_cassette("self.list_all") do

      response = Channel.list_all

      expect(response).must_be_kind_of Array
      expect(response[0]).must_be_kind_of Hash
      expect(response[0][:name]).must_be_kind_of String
      expect(response[0][:topic]).must_be_kind_of String
      expect(response[0][:member_count]).must_be_kind_of Integer
      expect(response[0][:slack_id]).must_be_kind_of String

      general_channel = response.find{ |channel| channel[:name] == "general"}
      expect(general_channel[:name]).must_equal "general"
    end

  end


end
