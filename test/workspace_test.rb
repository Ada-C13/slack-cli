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
end