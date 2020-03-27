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

  describe "self.details" do
    it "returns array of name and id" do
      recipient = Recipient.new("Test", "T00000001")
      expect(recipient.details["id"]).must_equal "T00000001"
      expect(recipient.details["name"]).must_equal "Test"
    end
  end

  describe "make_query" do
    it "raises error for invalid recipient type" do
      expect{Recipient.make_query("oogie-woogie")}.must_raise ArgumentError
    end
    
    it "generates needed information for a user list" do
      VCR.use_cassette("Recipient#make_query(user)") do
        user_list = Recipient.make_query("user")
        expect(user_list["ok"]).must_equal true
        expect(user_list["members"]).must_be_kind_of Array
      end

    end

    it "generates needed information for a channel list" do
      VCR.use_cassette("Recipient#make_query(channel)") do
        channel_list = Recipient.make_query("channel")
        expect(channel_list["ok"]).must_equal true
        expect(channel_list["channels"]).must_be_kind_of Array
      end

    end
    #how do I test for a bad API key??? 
    xit "throws API_Error when API_KEY is invalid" do
      VCR.use_cassette("query fail") do
        
        expect {
          
        }.must_raise API_Error
      end
    end
  end
end