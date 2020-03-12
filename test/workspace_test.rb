require_relative 'test_helper'

describe "Workspace" do
  describe "#initialize" do
    it "Creates an instance of workspace" do
      VCR.use_cassette("list_users") do
        workspace = Workspace.new
        expect(workspace).wont_be_nil
        expect(workspace).must_be_kind_of Workspace
      end
    end

    it "Responds to users" do
      VCR.use_cassette("list_users") do
        workspace = Workspace.new
        expect(workspace).must_respond_to :users
        expect(workspace.users).must_be_kind_of Array
        workspace.users.each do |user|
          expect(user).must_be_kind_of User
        end
      end
    end

    it "Responds to channels" do
      VCR.use_cassette("list_channels") do
        workspace = Workspace.new
        expect(workspace).must_respond_to :channels
        expect(workspace.channels).must_be_kind_of Array
        workspace.channels.each do |channel|
          expect(channel).must_be_kind_of Channel 
        end
      end
    end
  end

  describe "#list_users" do
    it "returns a list of users" do
      VCR.use_cassette("list_users") do
        workspace = Workspace.new
        expect(workspace.list_users).must_be_kind_of Array
        expect(workspace.list_users.length > 0).must_equal true
      end
    end
  end

  describe "#list_channels" do
    it "returns a list of channels" do
      VCR.use_cassette("list_channels") do
        workspace = Workspace.new
        expect(workspace.list_channels).must_be_kind_of Array
        expect(workspace.list_channels.length > 0).must_equal true
      end
    end
  end

  describe "#select_user" do
    it "selects existing user by assigning it to 'selected' variable" do
      VCR.use_cassette("list users") do
        workspace = Workspace.new
        workspace.select_user("UUT7ESHPU")
        expect(workspace.selected.slack_id).must_equal "UUT7ESHPU"
        expect(workspace.selected.name).must_equal "Ekaterina"
        p workspace.selected
      end
    end

    it "leaves 'selected' variable empty if user is not found" do
      VCR.use_cassette("list_users") do
        workspace = Workspace.new
        workspace.select_user("7ESHPU")
        expect(workspace.selected).must_equal ""
      end
    end
  end

  describe "#select_channel" do
    it "selects existing channel by assigning it to 'selected' variable" do
      VCR.use_cassette("list_channels") do
        workspace = Workspace.new
        workspace.select_channel("general")
        expect(workspace.selected.name).must_equal "general"
        p workspace.selected
      end
    end

    it "leaves 'selected' variable empty if channel is not found" do
      VCR.use_cassette("list_channel") do
        workspace = Workspace.new
        workspace.select_channel("nono")
        expect(workspace.selected).must_equal ""
      end
    end
  end
end