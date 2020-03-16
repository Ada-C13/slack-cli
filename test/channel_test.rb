require_relative 'test_helper.rb'


describe "Channel" do
  it "can initialize channel" do
    slack_id = "CUT6XEYR0"
    topic = "this is the topic"
    member_count = 14
    name = "Katie Test"
    new_channel = Channel.new(slack_id: slack_id, name: name, topic: topic, member_count: member_count)
    expect(new_channel).must_be_kind_of Channel
    expect(new_channel.slack_id).must_equal slack_id
    expect(new_channel.topic).must_equal topic
    expect(new_channel.member_count).must_equal member_count
    expect(new_channel.name).must_equal name

  end

  describe "self.get" do
    it "self.get api call works" do
      response = nil

      VCR.use_cassette("self.get") do
        params = {
          token: ENV['SLACK_TOKEN'],
        }
        response = Channel.get("https://slack.com/api/channels.list",params)
      end

      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
    end

    it "bad URL returns correct error" do
      response = nil

      VCR.use_cassette("bad_api_call") do
        params = {
          token: ENV['SLACK_TOKEN'],
        }
         expect{Channel.get("https://slack.com/api/bad.endpoint",params)}.must_raise ArgumentError
      end

    end
  end

  it "can list all channels" do
    VCR.use_cassette("self.list_all") do

      response = Channel.list_all

      expect(response).must_be_kind_of Array
      expect(response[0]).must_be_kind_of Channel
      expect(response[0].name).must_be_kind_of String
      expect(response[0].topic).must_be_kind_of String
      expect(response[0].member_count).must_be_kind_of Integer
      expect(response[0].slack_id).must_be_kind_of String

      general_channel = response.find{ |channel| channel.name == "general"}
      expect(general_channel.name).must_equal "general"
    end

  end


end
