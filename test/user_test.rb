require_relative 'test_helper'

describe "User class" do
  describe "user object initialize" do
    it "creates a user object" do
      VCR.use_cassette("initialze user object") do

        url = "https://slack.com/api/users.list"
        response = User.get(url)

        new_user = ""
        response["members"].each do |member|
          real_name = member["real_name"]
          status_emoji = member["profile"]["status_emoji"]
          status_text = member["profile"]["status_text"]
          return new_user = User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji)
        end
        
        expect(new_user).must_be_instance_of User
        expect(new_user.real_name).must_equal "Slackbot"
        
      end
    end
  end

  describe "self.list_all" do
    it "lists all the users' usernames, real names, and slack id " do
      VCR.use_cassette("list all users") do
        all_users = User.list_all

        expect(all_users.count).must_equal 11
        expect(all_users[1]["Slack ID"]).must_equal "UUTK13WE6"
        expect(all_users[1]["Username"]).must_equal "yesentorres"
        expect(all_users[1]["Real Name"]).must_equal "Yesenia Torres"
      end
    end
  end
  
end