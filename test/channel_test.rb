require_relative 'test_helper'
require_relative '../lib/slack'

describe "channel" do
  before do
    VCR.use_cassette("list-endpoint") do
      @workspace = Workspace.new

      @random_channel = @workspace.channels.find {|c| c.name == "random"}
    end
  end

  describe "initialize method" do
    it "will be an instance of the Channel class" do
      expect(@random_channel).must_be_instance_of Channel
    end

    it "will have the correct attributes" do
      expect(@random_channel).must_respond_to :slack_id
      expect(@random_channel.slack_id).must_equal "CV5H594KE"

      expect(@random_channel).must_respond_to :name
      expect(@random_channel.name).must_equal "random"

      expect(@random_channel).must_respond_to :topic
      expect(@random_channel.topic).must_be_instance_of String

      expect(@random_channel).must_respond_to :member_count
      expect(@random_channel.member_count).must_equal 8
    end
  end
  
  describe "get method" do
    before do
      VCR.use_cassette("list-endpoint") do
        url = "https://slack.com/api/conversations.list"

        @my_response = Channel.get(url)
      end
    end

    it "makes an API call" do
      expect(@my_response).must_be_instance_of HTTParty::Response
      expect(@my_response["ok"]).must_equal true
      expect(@my_response["channels"].first["id"]).must_equal "CUT7CLL1Y"
    end

    it "will throw an error if invalid url is given" do
      VCR.use_cassette("error-cases") do
        expect{Channel.get("https://slack.com/api/lololthisisntreal")}.must_raise ArgumentError
      end
    end
  end

  describe "send message method" do
    before do
      VCR.use_cassette("post-message-endpoint") do
        my_message = "Test message!"
        @random_channel.send_message(my_message)

      end
    end

  end

  describe "details method" do
    it "returns a formatted list of its own deets" do
      expect(@random_channel.details).must_be_instance_of TablePrint::Returnable
    end
  end

  describe "list all method" do
    before do
      VCR.use_cassette("list-endpoint") do
        @my_channels = Channel.list_all
      end
    end

    it "can be called" do
      expect(@my_channels).must_be_instance_of Array
      expect(@my_channels.first).must_be_instance_of Channel
    end

    it "returns a full list of all channels" do
      expect(@my_channels.length).must_equal 3
      expect(@my_channels[0].name).must_equal "general"
      expect(@my_channels[0].member_count).must_equal 8
      expect(@my_channels.last).must_be_instance_of Channel
    end
  end


end