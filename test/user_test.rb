require_relative 'test_helper'

describe "User class" do
  describe "user object initialize" do
    it "creates a user object" do
      VCR.use_cassette("initialze user object") do

        url = "https://slack.com/api/users.list"
        response = User.get(url)

        new_user_array = []
        response["members"].each do |member|
          real_name = member["real_name"]
          status_emoji = member["profile"]["status_emoji"]
          status_text = member["profile"]["status_text"]
          slack_id = member["id"]
          name = member["name"]
          new_user_array << new_user = User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji, slack_id: slack_id, name: name)
        end
        
        expect(new_user_array[0]).must_be_instance_of User
        expect(new_user_array[0].real_name).must_equal "Slackbot"
        
      end
    end
  end

  describe "self.list_all" do
    it "lists all the users' usernames, real names, and slack id " do
      VCR.use_cassette("list all users") do
        all_users = User.list_all

        expect(all_users.count).must_equal 11
        expect(all_users[1].slack_id).must_equal "UUTK13WE6"
        expect(all_users[1].name).must_equal "yesentorres"
        expect(all_users[1].real_name).must_equal "Yesenia Torres"
      end
    end
  end
  
end