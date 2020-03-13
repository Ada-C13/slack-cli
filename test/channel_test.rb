require "test_helper"

describe "Channel Class" do
  before do
    @channel = Channel.new(name: "Elves", slack_id: "qwerty098", topic: "Elves of our world talking stuff!", member_count: 4)
  end
  describe "Instantiation" do
    it "creates an instanse of Channel" do
      expect(@channel).must_be_kind_of Channel
    end

    it "has name" do
      expect(@channel.name).must_equal "Elves"
    end

    it "has topic" do
      expect(@channel.topic).must_equal "Elves of our world talking stuff!"
    end

    it "topic is shown as 'not set' if being passed an empty string" do
      channel = Channel.new(name: "Orks", slack_id: "qwerty765", topic: "", member_count: 2)
      expect(channel.topic).must_equal "not set"
    end 

    it "has member count" do
      expect(@channel.member_count).must_equal 4
    end

    it "has Slack ID" do
      expect(@channel.slack_id).must_equal "qwerty098"
    end
  end

  describe "get_details" do
    it "print a string" do
      expect(@channel.get_details).must_be_kind_of String
    end

    it "string includes channel's name, topic, member count and Slack ID" do
      expect(@channel.get_details.include? "qwerty098").must_equal true
      expect(@channel.get_details.include? "Elves").must_equal true
      expect(@channel.get_details.include? "Elves of our world talking stuff!").must_equal true
      expect(@channel.get_details.include? "4").must_equal true
    end
  end
end