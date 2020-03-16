require_relative "test_helper"




describe "Workspace" do
  before do
    VCR.use_cassette("new_workspace") do
      @workspace = SlackApi::Workspace.new
      @users = @workspace.get_users_from_api
      @channels = @workspace.get_channels_from_api
    end 
  end 
 
  it "Creates an instance of Workspace" do
    expect(@workspace).must_be_instance_of SlackApi::Workspace
    expect(@workspace).must_respond_to :users
    expect(@workspace).must_respond_to :channels
  end

  it "Initializes @users as an array of users " do
    expect(@users).must_be_kind_of Array
    expect(@users[0].slack_id).must_equal "USLACKBOT"
    expect(@users[0].name).must_equal "slackbot"
    expect(@users[0].real_name).must_equal "Slackbot"
  end


  it "Initializes @channels as an array of channels " do
    expect(@channels).must_be_kind_of Array
    expect(@channels[0].name).must_equal "general"
    expect(@channels[0].slack_id).must_equal "CUT6XEYR0"
    expect(@channels[0].topic).must_equal "Company-wide announcements and work-based matters"
    expect(@channels[0].member_count).must_be_kind_of Integer
    expect(@channels[0].member_count).must_equal 5
  end

   
  # it "will raise an exception if the search fails" do
  #   VCR.use_cassette("new_workspace") do
  #     users = []
  #     expect {
  #       response = get_users_from_api
  #     }.must_raise SlackAPIError
  #   end
  # end
end #before block end
