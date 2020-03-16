require_relative 'test_helper'

describe "class User < Recipient" do

  before do
    @id = "UV6AV2NRW"
    @name = "suely"
    @real_name = "Suely Barreto"
    @status_text = ""
    @status_emoji = ""
    @user = User.new(@id, @name, @real_name, @status_text, @status_emoji)
  end # before

  # Constructor
  describe "constructor" do
    it "takes id, name, real_name, status_text, status_emoji" do
      expect(@user).must_be_kind_of User
      expect(@user.id).must_equal @id
      expect(@user.name).must_equal @name
      expect(@user.real_name).must_equal @real_name
      expect(@user.status_text).must_equal @status_text
      expect(@user.status_emoji).must_equal @status_emoji
    end
  end # describe "constructor"

  # Return details for a user
  describe "details" do
    it "returns a string" do
      expect(@user.details).must_be_kind_of String
    end
  end # describe "details"

  describe "self.get" do
    it "takes a method and returns HTTParty results" do
      VCR.use_cassette("list") do 
        result   = Recipient.get("users.list")
        expect(result).must_be_kind_of HTTParty::Response
        expect(result.code).must_equal 200
        expect(result["ok"]).must_equal true
      end
    end

    it "raises an error if the call fails" do
      VCR.use_cassette("fail") do 
        expect{ Recipient.get("fail.list") }.must_raise RuntimeError
      end
    end
  end # describe "self.get"

  # Get users from slack
  describe "self.list_all" do
    it "returns an array of users" do 
      VCR.use_cassette("list") do 
        users = User.list_all
        expect(users).must_be_kind_of Array
        expect(users.size).must_be :>, 0
        users.each do |user|
          expect(user).must_be_kind_of User
        end
      end
    end
  end # describe "self.list_all"

end # Class
