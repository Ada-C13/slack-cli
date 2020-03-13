require_relative 'test_helper'

describe 'initialize' do
  
  it 'instantiates a workspace object' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace).must_be_instance_of Workspace
      expect(@workspace).must_respond_to :users
    end
  end
  
  it 'contains an array of user objects' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.users[0]).must_be_instance_of User
    end 
  end
  
  it 'contains an array of channel objects' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.channels).must_be_kind_of Array
      expect(@workspace.channels[0]).must_be_instance_of Channel
    end
  end
  
  it 'initial value of selected is nil' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.selected).must_be_nil
    end
  end
end


describe 'select channel' do
  
  it "selects the correct channel for slack names" do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      user_channel = "general"
      @workspace.select_channel(user_channel)
      
      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected).must_respond_to :name
      expect(@workspace.selected.name).must_equal "general"
    end
  end
  
  it "selects the correct channel for slack ids" do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      user_channel = "CUTE4M96W"
      @workspace.select_channel(user_channel)
      
      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected).must_respond_to :slack_id
      expect(@workspace.selected.slack_id).must_equal "CUTE4M96W"
    end
  end
  
  
  it 'returns iempty array if channel is not found' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      user_channel = "fake channel"
      selected_channel = @workspace.select_channel(user_channel)
      
      expect(selected_channel).must_be_empty
    end
  end
  
  it 'selects the correct channel after having a previous selection' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      first_channel = "random"
      @workspace.select_channel(first_channel)
      second_channel = "CUTE4M96W"
      @workspace.select_channel(second_channel)
      
      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_instance_of Channel
      expect(@workspace.selected).must_respond_to :slack_id
      expect(@workspace.selected.slack_id).must_equal "CUTE4M96W"
    end
  end
  
end


describe 'select user' do
  
  it "selects the correct user for slack names" do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      
      user = "slackbot"
      @workspace.select_user(user)
      
      # expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_instance_of User
      expect(@workspace.selected).must_respond_to :name
      expect(@workspace.selected.name).must_equal "slackbot"
    end
  end
  
  it "selects the correct user for slack ids" do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      user = "USLACKBOT"
      @workspace.select_user(user)
      
      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_instance_of User
      expect(@workspace.selected).must_respond_to :slack_id
      expect(@workspace.selected.slack_id).must_equal "USLACKBOT"
    end
  end
  
  it 'returns empty array if user is not found' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      user = "fake user"
      selected_user = @workspace.select_user(user)
      
      expect(selected_user).must_be_empty
    end
  end
  
  it 'selects the correct user after having a previous selection' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      first_user = "yesentorres"
      @workspace.select_user(first_user)
      second_user = "slackbot"
      @workspace.select_user(second_user)
      
      expect(@workspace.selected).wont_be_nil
      expect(@workspace.selected).must_be_instance_of User
      expect(@workspace.selected).must_respond_to :slack_id
      expect(@workspace.selected.name).must_equal "slackbot"
    end
  end
  
end


describe 'show details' do
  
  it 'displays accurate details about a user' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      @workspace.select_user("slackbot")
      expect(@workspace.show_details).must_equal "Slack ID: USLACKBOT, Name: slackbot, Real Name: Slackbot, Status Text: , Status Emoji: "
    end
  end
  
  it 'displays accurate details about a channel' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      @workspace.select_channel("CUTE4M96W")
      expect(@workspace.show_details).must_equal "Slack ID: CUTE4M96W, Name: general, Topic: Company-wide announcements and work-based matters, Member Count: 4"
    end
  end
  
  it 'informs the user if there is no currently selected user or channel' do
    VCR.use_cassette("load_workspace") do
      @workspace = Workspace.new
      expect(@workspace.show_details).must_be_empty
    end
  end
  
end




