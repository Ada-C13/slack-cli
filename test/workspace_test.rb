require_relative "test_helper"

describe "initialize" do
  before do
    @workspace = Workspace.new
  end

  it "creates a new instance of Workspace" do
    expect(@workspace).must_be_kind_of Workspace
    expect(@workspace).must_respond_to :users
    expect(@workspace).must_respond_to :channels
  end

  it "initializes @users to be an empty array" do 
    expect(@workspace.users).must_be_kind_of Array
    expect(@workspace.users).must_be_empty
  end

  it "initializes @channels to be an empty array" do 
    expect(@workspace.channels).must_be_kind_of Array
    expect(@workspace.channels).must_be_empty
  end
end

describe "list_channels" do

  before do
    @workspace = Workspace.new
  end

  it "returns an array of channel instances" do
    VCR.use_cassette("list_channels") do
      channels = @workspace.list_channels

      expect(channels).must_be_kind_of Array
    end
  end


  it "can find the channels" do
    VCR.use_cassette("list_channels") do
      channels = @workspace.list_channels

      expect(channels).wont_be_nil
      expect(channels.length).must_equal 3
      expect(channels).must_equal ["general", "api-testing", "random"]

      # expect(response["Seattle"][:lon]).must_equal "-122.3300624"
      # expect(response["Seattle"][:lat]).must_equal "47.6038321"
    end
  end   
      
    # it "will raise an exception if the search fails" do
    #   VCR.use_cassette("location_find") do
    #     location = ""
    #     expect {
    #       response = get_location(location)
    #     }.must_raise SearchError
    #   end
    # end

  it "lists the correct number of channel instances" do

  end

  it "lists the expected channels in the workspace" do
  
  end




end