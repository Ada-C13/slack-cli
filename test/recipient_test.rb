require_relative "test_helper"

describe 'Recipient class' do
  describe 'get method can get information from a provided url' do
    it 'gets channels.list' do
      VCR.use_cassette("channels") do
        response = Recipient.get("https://slack.com/api/channels.list")

        expect(response["ok"]).must_equal true
        expect(response["channels"].length).must_equal 3
        expect(response["channels"][0]).must_include "id"
      end
    end

    it 'gets users.list' do
      VCR.use_cassette("users") do
        response = Recipient.get("https://slack.com/api/users.list")

        expect(response["ok"]).must_equal true
        expect(response["members"].length).must_equal 10
        expect(response["members"][0]).must_include "id"
      end
    end

    it 'raises an exception if there was any other response than a 200' do
      expect{Recipient.get("htt://sack.com/pi/chanels.lis")}.must_raise Exception
    end
  end

  describe 'send_message method sends a message to a user or channel' do
    it 'sends a message to a user' do
      VCR.use_cassette("sent_messages") do
        slackbot = User.new(slack_id: "USLACKBOT", name: "slackbot", real_name:"Slackbot")
        response = slackbot.send_message("Hello World")
        expect(response.code).must_equal 200
      end
    end

    it 'sends a message to a channel' do
      VCR.use_cassette("sent_messages") do
        random = Channel.new(slack_id: "CV86RT7AS", name: "random", member_count: "5", topic: "Non-work banter and water cooler conversation")
        response = random.send_message("Hello World")
        expect(random.send_message("Hello World").code).must_equal 200
      end
    end

    it 'raises an exception if there was any other response than a 200' do
      slackbot = User.new(slack_id: "USLABOT", name: "slaot", real_name:"Slakbot")
      expect{slackbot.send_message("Hello World")}.must_raise Exception
    end
  end
end