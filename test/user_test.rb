require_relative 'test_helper'


describe SlackCli::User do
  describe "User Class" do

    it "can generate all users as a class" do
      VCR.use_cassette("slack-posts") do

        data = SlackCli::User.get_all
        
        expect(data[0]).must_be_instance_of SlackCli::User

      end
    end

  end 
end
