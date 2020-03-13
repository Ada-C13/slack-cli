require_relative "test_helper"

describe "User class" do
  # describe "#initialize" do 
  # end 

  describe "self.get" do 
    it "returns a response of users list from API" do
      VCR.use_cassette("User.get") do
        url = "https://slack.com/api/users.list"
        query = {
          token: ENV["SLACK_TOKEN"]
        }

        response = Slack::User.get(url, query)
        
        expect(response["ok"]).must_equal true
      end  
    end     
  end 

  describe "#details" do
    it "returns the user details" do 
      VCR.use_cassette("User#details") do 
        slack_id = "USLACKBOT"
        name = "slackbot"
        real_name = "Slack bot"
        status_text = "Wroking remotely"
        status_emoji = "🏡"

        user = Slack::User.new(slack_id: slack_id, name: name, real_name: real_name, status_text: status_text, status_emoji: status_emoji)

        expect(user.details).must_be_kind_of Array      
        expect(user.details.length).must_equal 5   
        expect(user.details[0]).must_equal slack_id    
        expect(user.details[1]).must_equal name  
        expect(user.details[2]).must_equal real_name  
        expect(user.details[3]).must_equal status_text  
        expect(user.details[4]).must_equal status_emoji   
      end 
    end 
  end 


  describe "self.list_all" do 
    it "creates and returns instances of users" do 
      VCR.use_cassette("User.list_all") do 
        user_list = Slack::User.list_all 

        expect(user_list).must_be_kind_of Array 

        user_list.each do |user|
          expect(user).must_be_kind_of Slack::User
        end 
      end 
    end 
  end 
end