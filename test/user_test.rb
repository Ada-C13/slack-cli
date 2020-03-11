require_relative "test_helper"

describe "User class" do
  # describe "#initialize" do 
  # end 

  describe "self.get" do 
    it "returns a response of users list from API" do
      VCR.use_cassette("find_user_list") do
        url = "https://slack.com/api/users.list"
        query = {
          token: ENV["SLACK_TOKEN"]
        }

        response = Slack::User.get(url, query)
        
        expect(response["ok"]).must_equal true
      end  
    end     
  end 

  describe "self.list_all" do 
    it "creates and returns instances of users" do 
      VCR.use_cassette("make_user_list") do 
        user_list = Slack::User.list_all 

        expect(user_list).must_be_kind_of Array 

        user_list.each do |user|
          expect(user).must_be_kind_of Slack::User
        end 
      end 
    end 
  end 
end