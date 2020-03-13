require_relative 'test_helper'

describe "Recipient Access - Working Case" do
  it 'access all users' do
    VCR.use_cassette("get_users") do
      url = 'https://slack.com/api/users.list'
      users = Recipient.get_recipients(url)
 
      expect(users["ok"]).must_equal true
      expect(users["members"][0]["name"]).must_equal "slackbot"
      expect(users["members"][0]["real_name"]).must_equal "Slackbot"
      expect(users["members"][0]["id"]).must_equal "USLACKBOT"
    end
  end

  it 'access all channels' do
    VCR.use_cassette("get_channels") do
      url = 'https://slack.com/api/channels.list'
      channels = Recipient.get_recipients(url)

      expect(channels["ok"]).must_equal true
      expect(channels["channels"][0]["name"]).must_equal "general"
      expect(channels["channels"][0]["members"].length).must_equal 1
      expect(channels["channels"][0]["id"]).must_equal "CUVFN5GQ1"
      expect(channels["channels"][0]["topic"]["value"]).must_equal "Company-wide announcements and work-based matters"
    end
  end

  it 'able to send messages' do
    VCR.use_cassette("send_message") do
      recipient = Recipient.new('general','CUVFN5GQ1')
      response = recipient.send_message("Hello World")

      expect(response).must_include "successfully"
    end
  end

  it 'do not send messages if information is incorrect' do
    VCR.use_cassette("fail_message") do
      recipient = Recipient.new('general','EVILBOT')
      response = recipient.send_message("Hello World")

      expect(response).must_include "unsucessful"
    end
  end

  it 'will raise argument error if incorrect url' do
    VCR.use_cassette("incorrect_url") do
      url = 'https://slack.com'
      expect {
        Recipient.get_recipients(url)
      }.must_raise SearchError
    end
  end
end


  # user can exit out of program
  # after command "quit" is entered, unable to interact with interface anymore


  # Messages are sent from bot

# test for invalid token?