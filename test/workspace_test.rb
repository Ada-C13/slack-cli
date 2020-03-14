require_relative "test_helper"
require 'httparty'

describe "getting number of channels" do

  it "can get number of channels" do
    VCR.use_cassette("channels") do
      response = Workspace.new
  
      expect(response.channels).wont_be_nil
      expect(response.num_of_channels).must_equal 5
    end
    
  end   
   
end

describe "getting number of users" do

  it "can get number of users" do
    VCR.use_cassette("users") do
      response = Workspace.new
     
      expect(response.users).wont_be_nil
      expect(response.num_of_users).must_equal 8
    end 
  end  
end

xdescribe "list_users" do  # look in to test the 2 listing functions do i need to break the functin apart?

  it "outputs list of users" do
    result = {}
      VCR.use_cassette("list_of_users") do
        result = Workspace.get("https://slack.com/api/users.list")
      end

      expect(result).must_be_kind_of HTTParty::Response
      expect(result["ok"]).must_equal true
    
  end 

  it "raises an error when a call fails" do
    VCR.use_cassette("list_of_users") do
      expect {User.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError  #from Devins live code
    end
  end
end

# xdescribe "list user"
#   xdescribe "self.get" do
#    xit "get s a list of users " do
#      result = {}
#      VCR.use_cassette ("user-list-endpoint") do
#       result = User.get("https://slack.com/api/users.list")
#      end
     
#      expect(results).must_be_kind_of HTTParty::Response
#      expect(result.("ok")).must_equal true
#    end
  
#    xit "raises an error when a call fails" do
#     VCR.use_cassette ("user-list-endpoint") do
      
#       expect{User.get(https://slack.com/api/bogus.endpoint)}.must_raise SlackAPIError
#     end
#    end
#   end

#   xderscribe "self.list" do
#     it "return a valid list of the users"


# end

