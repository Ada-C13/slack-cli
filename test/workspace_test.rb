require_relative 'test_helper'
#require_relative '../lib/user'
#require_relative '../lib/channel'
require_relative '../lib/workspace'

describe SlackCli::Workspace do
  describe "Workspace" do
    describe "Workspace Instantiation" do
      it "creates an instance of a workspace" do
        puts "here"
      #   #create a known workspace
        #VCR.use_cassette("workspace-details", :record => :new_episodes) do
          #test_workspace = SlackCli::Workspace.new()

          #expect a workspace to be workspace object
          #expect(test_workspace).must_be_kind_of SlackCli::Workspace
      #   # expect(test_workspace.name).must_equal "channelname"
        #end
      end

      # it "validates Channel paramters" do
      #   expect{SlackCli::Channel.new("1", 1, "channeltopic", "channelmembercount")}.must_raise ArgumentError
      # end
    end #instance of workspace
  end #class
end #module