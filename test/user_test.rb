require_relative "test_helper"

# describe "user initializes" do

#   it "user initializes with name" do
#     recipient = User.new("Ada")
  
#       expect(recipient).must_be_instance_of User
#       expect(recipient.name).must_equal "Ada"
#   end  
    

#   it "user initializes with id" do
#     recipient = User.new(nil, "A100")
  
#       expect(recipient).must_be_instance_of User
#       expect(recipient.id).must_equal "A100"
#   end  

   
# end
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