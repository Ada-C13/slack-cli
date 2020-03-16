require_relative "test_helper.rb"
describe "Recipient" do
  describe "constructor" do
    before do
      @recipient = Recipient.new("Test", "T00000001")
    end
    it "creates Recipient" do
      expect(@recipient).must_be_kind_of Recipient
    end
    it "has state" do
      expect(@recipient.name).must_equal "Test"
      expect(@recipient.slack_id).must_equal "T00000001"
    end
  end

  describe "details" do
    it "returns array of name and id" do
      recipient = Recipient.new("Test", "T00000001")
      target_a = ["Test", "T00000001"]
      expect(recipient.details).must_equal target_a
    end
  end

  describe "get_list" do
    it "raises error for invalid recipient type" do
      expect{Recipient.get_list("oogie-woogie")}.must_raise ArgumentError
    end
    
    it "generates needed information for a user list" do
      VCR.use_cassette("Recipient#get_list(user)") do
        user_list = Recipient.get_list("user")
        expect(user_list["ok"]).must_equal true
        expect(user_list["members"]).must_be_kind_of Array
      end

    end

    it "generates needed information for a channel list" do
      VCR.use_cassette("Recipient#get_list(channel)") do
        channel_list = Recipient.get_list("channel")
        expect(channel_list["ok"]).must_equal true
        expect(channel_list["channels"]).must_be_kind_of Array
      end

    end

    # how do I write a test for my API_Error? I need an invalid
    # token to be passed in a way that won't mess up all the other
    # tests....can I force a different value of API_KEY (located
    # in lib/lib_helper) in a particular test?
    # looked into dotenv - not much luck without using bash 
    # could write another option into source code to test this - but
    # i don't like this option

    # this doesn't work:
    # it "throws API_Error when API_KEY is invalid" do
    #   expect {
    #     ENV["SLACK_TOKEN"]= "xoxb-98095036Y595-980354253761-FBM9Y9WcbC3S90lUbCYMG0ET"
    #     Recipient.get_list("user")
    #   }.must_raise API_Error
    # end
  end
end