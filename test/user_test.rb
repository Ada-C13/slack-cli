require_relative 'test_helper'

describe SlackCli::User do
  describe "User Class" do

    it "can generate all users as a class" do
      VCR.use_cassette("users_list") do
        data = SlackCli::User.list_all
        expect(data[0]).must_be_instance_of SlackCli::User

        data.each do |user|
          expect(user).must_be_instance_of SlackCli::User
        end 

      end
    end


    it "can send message to user" do 
      VCR.use_cassette("users_list") do
        data = SlackCli::User.list_all
        response = data[0].send_msg("hey there user!")
        expect(response).must_equal true 
      end 
    end 

  end 
end
