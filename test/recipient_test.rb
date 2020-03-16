require_relative 'test_helper'

describe "class Recipient" do

  before do
    @id = "USLACKBOT"
    @name = "slackbot"
    @recipient = Recipient.new(@id, @name)
  end # before

  # Constructor
  describe "constructor" do
    it "takes id and name" do
      expect(@recipient).must_be_kind_of Recipient
      expect(@recipient.id).must_equal @id
      expect(@recipient.name).must_equal @name
    end
  end # describe "constructor"

  describe "send_message" do
    it "sends a message" do
      VCR.use_cassette("send") do 
        result = @recipient.send_message("test")
        expect(result).must_be_kind_of HTTParty::Response
        expect(result.code).must_equal 200
        expect(result["ok"]).must_equal true
        expect(result["message"]["text"]).must_equal "test"
      end
    end

    it "raises an Error if HTTP Result is not 200" do
      VCR.use_cassette("send500") do 
        expect { @recipient.send_message("test") }.must_raise RuntimeError
      end
    end

    it "raises an Error if Slack says it's not ok" do
      VCR.use_cassette("sendnotok") do 
        expect { @recipient.send_message("test") }.must_raise RuntimeError
      end
    end

    it "raises an error if message is not a string" do
      expect { @recipient.send_message(1) }.must_raise ArgumentError
      expect { @recipient.send_message([]) }.must_raise ArgumentError
    end

  end # describe "send_message"

  describe "self.get" do
    it "takes a method and returns HTTParty results" do
      VCR.use_cassette("list") do 
        result1 = Recipient.get("conversations.list")
        expect(result1).must_be_kind_of HTTParty::Response
        expect(result1.code).must_equal 200
        expect(result1["ok"]).must_equal true

        result2 = Recipient.get("users.list")
        expect(result2).must_be_kind_of HTTParty::Response
        expect(result2.code).must_equal 200
        expect(result2["ok"]).must_equal true
      end
    end

    it "raises an error if the call fails" do
      VCR.use_cassette("fail") do 
        expect{ Recipient.get("fail.list") }.must_raise RuntimeError
      end
    end
  end # describe "self.get"

end # describe "class Recipient"