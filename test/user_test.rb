require_relative 'test_helper'
require_relative '../lib/user'

describe SlackCli::User do
  describe "User" do
    describe "User Instantiation" do
        it "creates an instance of a user" do
          #create a known user
          test_user = SlackCli::User.new("1", "testname", "testrealname", "testtext", "testemoji")
          #expect a user
          expect(test_user).must_be_kind_of SlackCli::User
          expect(test_user.name).must_equal "testname"
        end

        it "validates User paramters" do
          expect{SlackCli::User.new("1", 12, "testrealname", "testtext", "testemoji")}.must_raise ArgumentError
        end
        
    end #instance of user

    describe "self.load_all users method" do
      it "returns a list all users" do
        url = ENV['BASE_URL'] + ENV['SUB_USER_URL'] + "token=" + ENV['SLACK_TOKEN']
        VCR.use_cassette("user-details") do
          response = SlackCli::User.load_all(url)
          response.each do |user|
            expect(user).must_be_kind_of SlackCli::User
            expect(user).must_respond_to :id
          end

          # make sure kate is in the users array
          user_app = response.find_all { |user| user.id == "UV3CAV859" }
          expect(user_app[0].name).must_equal "space_kate_m_api_proj"
        end
      end  
    end
  end #class
end #modeul