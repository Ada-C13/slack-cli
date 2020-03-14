require_relative "test_helper"
require_relative "../lib/user"


describe "User class" do
  describe 'User instantiation' do
    before do
      @user = User.new(real_name: "Slackbot", status_text: "", status_emoji: "", slack_id: "CV5KNMDKN", name: "slack-cli")
    end
    
    it "is an instance of User" do
      expect(@user).must_be_kind_of User
    end

    it "is set up for specific attributes and data     types" do
      [:real_name, :status_text, :status_emoji, :slack_id, :name].each do |prop|
        expect(@user).must_respond_to prop
      end
      
      expect(@user.real_name).must_be_kind_of String
      expect(@user.name).must_be_kind_of String
      expect(@user.status_text).must_be_kind_of String
      expect(@user.slack_id).must_be_kind_of String
      expect(@user.status_emoji).must_be_kind_of String
    end
  end
end

# describe Channel do
#   describe 'constructor' do

#     it "Creates an instance of user" do
#       real_name = "Slackbot"
#       status_text = ""
#       status_emoji = ""
#       user = User.new("Slackbot", "", "")
#       user.must_be_kind_of User
#     end

#     it 'Keep treck of real_name' do
#       real_name = "Slackbot"
#       status_text = ""
#       status_emoji = ""
#       user = User.new(real_name, status_text, status_emoji)
#       user.must_respond_to :real_name
#       expect(user.real_name).must_equal "Slackbot"
#     end

#     it 'Keep treck of slack member_count' do
#       real_name = "Slackbot"
#       status_text = ""
#       status_emoji = ""
#       user = User.new(real_name, status_text, status_emoji)
#       user.must_respond_to :status_text
#       expect(user.status_text).must_equal ""
#     end

#     it 'Keep treck of slack status_text' do
#       real_name = "Slackbot"
#       status_text = ""
#       status_emoji = ""
#       user = User.new(real_name, status_text, status_emoji)
#       user.must_respond_to :status_emoji
#       expect(user.status_emoji).must_equal ""
#     end
#   end


#   describe 'self_get' do
#     it "gets a list of users and return them as an HTTParty Response " do
#       result = {}
#       VCR.use_cassette("user-list-endpoint") do
#         result = User.get("https://slack.com/api/users.list")
#       end

#       expect(result).must_be_kind_of HTTParty::Response
#       expect(result.["ok"]).must_equal true

#     end
#     it "gets a list of users and return them as an HTTParty Response " do
#       VCR.use_cassette("user-list-endpoint") do
#         expect{User.get("https://slack.com/api/users.list").must_raise SlackAPIError
#       end
#     end
#   end



#   # describe 'self.list' do
#   #   it "return a valid list of the users " do
#   #     result = []
#   #     VCR.use_cassette("user-list-endpoint") do
#   #       result = User.list.all
#   #     end
#   #     expect(result).must_be_kind_of Array
#   #     expect(result.length).must_be :> 0
#   #     result.each do |user|
#   #       expect(user).must_be_kind_of User
#   #     end
      

#   #   end
#   #   it "gets a list of users and return them as an HTTParty Response " do
#   #     VCR.use_cassette("user-list-endpoint") do
#   #       expect{User.get("https://slack.com/api/users.list").must_raise SlackAPIError
#   #     end
#   #   end
#   # end
  



# end