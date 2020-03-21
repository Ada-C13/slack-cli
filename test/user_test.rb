require_relative 'test_helper'

describe "User Class" do

  describe "User instantiation" do
    before do
      @user = SlackCli::User.new(slack_id: "UV6BANLCV" ,name: "hala", real_name: "hala haddad", status_text: :AVAILABLE, status_emoji: nil)
      @user2 = SlackCli::User.new(slack_id: "UV868PVCP" ,name: "hala", real_name: "hala haddad", status_text: :AVAILABLE, status_emoji: nil)
    end

    it "is an instance of Channel" do
      expect(@user).must_be_kind_of SlackCli::User
    end
    
    it "must list details of the user" do
        expect(@user.details).must_equal [{"slack_id" => "UV6BANLCV","name" => "hala","real_name" => "hala haddad", "status_text" => :AVAILABLE, "status_emoji" => nil }]
    end

    it "can send a message to a user"do
        VCR.use_cassette("send messages to user") do
            expect(@user2.send_message("hi!")).must_equal true && 200
            expect(@user2.send_message("if you can see this")).must_equal true &&  200
            expect(@user2.send_message("it means my user.send method is working")).must_equal true && 200
            expect(@user2.send_message("hi five!")).must_equal true &&  200
        end
    end

    it "can list all users"do
    VCR.use_cassette("lists users") do
      expect(SlackCli::User.list_all.length).must_equal 11
    end
end
  end
end