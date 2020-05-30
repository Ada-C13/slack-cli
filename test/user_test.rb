require_relative "test_helper"

describe "User class" do
  describe 'User instantiation' do
    it "creates a user object" do
        
      VCR.use_cassette("list-user-endpoint") do
        url = "https://slack.com/api/users.list"
        response = User.get(url)

        users = []
        response["members"].each do |member|
          real_name = member["real_name"]
          status_emoji = member["profile"]["status_emoji"]
          status_text = member["profile"]["status_text"]
          slack_id = member["id"]
          name = member["name"]

          users << User.new(real_name: real_name, status_text: status_text, status_emoji: status_emoji, slack_id: slack_id, name: name)
        end

        expect(users[0]).must_be_instance_of User

        expect(users[0].real_name).must_equal "Slackbot"
        expect(users[0].status_text).must_equal ""
        expect(users[0].slack_id).must_equal "USLACKBOT"
        expect(users[0].name).must_equal "slackbot"
        expect(users[0].status_emoji).must_equal ""
      end
    end
  end


  describe "self.get" do
    it "can get a list of users" do
      result = {}
      VCR.use_cassette("list-user-endpoint") do
        result = User.get("https://slack.com/api/users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    end

    it "raises an error when a call fails" do
      VCR.use_cassette("list-user-endpoint") do
        expect {User.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
      end
    end
  end

  describe "self.list_all" do
    it "returns a list of valid users" do
      result = []
      VCR.use_cassette("list-user-endpoint") do
        result = User.list_all
      end

      expect(result).must_be_kind_of Array
      expect(result.length).must_be :>, 0
      result.each do |item|
        expect(item).must_be_kind_of User
      end
    end
  end
end



  



  
  

