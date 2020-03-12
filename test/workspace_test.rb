require_relative 'test_helper'

describe 'initialize' do
  before do
    @workspace = Workspace.new
  end
  
  it 'instantiates a workspace object' do
    expect(@workspace).must_be_instance_of Workspace
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.selected).must_be_kind_of Array
  end
  
end

describe 'list channels' do
  before do
    @workspace = Workspace.new
  end
  
  it 'can find channels' do
    VCR.use_cassette('list_channels') do
      channels = @workspace.list_channels
      
      expect(channels).must_be_kind_of Array
      expect(channels.length).must_equal 3
      expect(channels).must_equal ["general", "api-testing", "random"]
    end
  end
  
end

# describe "get_location" do
#   it "can find a location" do
#     VCR.use_cassette("location_find") do
#       location = "Seattle"
#       response = get_location(location)

#       expect(response["Seattle"]).wont_be_nil
#       expect(response["Seattle"][:lon]).must_equal "-122.3300624"
#       expect(response["Seattle"][:lat]).must_equal "47.6038321"
#     end
#   end   

#   it "will raise an exception if the search fails" do
#     VCR.use_cassette("location_find") do
#       location = ""
#       expect {
#         response = get_location(location)
#       }.must_raise SearchError
#     end
#   end
# end