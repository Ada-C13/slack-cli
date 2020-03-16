require_relative 'test_helper'

xdescribe 'Workspace' do 
  describe 'constructor' do
    before do
      VCR.use_cassette("workspace") do
        @workspace = Workspace.new
      end
    end
    it 'creates instance of Workspace' do
      expect(@workspace).must_be_kind_of Workspace
    end
    it 'has state @users and @channels' do
      expect(@workspace.users).must_be_kind_of Array
      expect(@workspace.channels).must_be_kind_of Array
    end
    it "users contains users" do
      expect(@workspace.users.first).must_be_kind_of User
      target_user = @workspace.users.find {|user| user.name == "slackbot"}
      expect(target_user).must_be_kind_of User
    end

    it "users contains users" do
      expect(@workspace.channels.first).must_be_kind_of Channel
      target_channel = @workspace.channels.find {|channel| channel.name == "random"}
      expect(target_user).must_be_kind_of Channel
    end
  end
end