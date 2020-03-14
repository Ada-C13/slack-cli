require_relative "test_helper"

describe "recipient user factory self.create" do

  it "self.create works with user name" do
    recipient = User.create("Ada", "user_name")
  
      expect(recipient).must_be_instance_of User
      expect(recipient.name).must_equal "Ada"
  end  
    

  it "self.create works with USER id" do
    recipient = User.create("A100", "user_id")
  
      expect(recipient).must_be_instance_of User
      expect(recipient.id).must_equal "A100"
  end  

   
end
# xdescribe "user"
#   xdescribe "self.get" do
#    it "get s a list of users " do
#      result = {}
#      VCR.use_cassette ("user-list-endpoint") do
#       result = User.get("https://slack.com/api/users.list")
#      end
     
#      expect(results).must_be_kind_of HTTParty::Response
#      expect(result.("ok")).must_equal true
#    end
  
#    it "raises an error when a call fails" do
#     VCR.use_cassette ("user-list-endpoint") do
      
#       expect{User.get(https://slack.com/api/bogus.endpoint)}.must_raise SlackAPIError
#     end
#    end
#   end

# #   xderscribe "self.list" do
# #     it "return a valid list of the users"


# # end