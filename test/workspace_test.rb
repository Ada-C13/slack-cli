require_relative "test_helper"

describe "WorkSpace class" do
  it "WorkSpace instantiation" do
    VCR.use_cassette("list-channel-endpoint") do
      workspace = WorkSpace.new
      workspace.must_be_instance_of WorkSpace

      expect(workspace.channels).must_be_instance_of Array
      expect(workspace.users).must_be_instance_of Array
      expect(workspace.selected).must_be_nil
    end
  end

  it "select channel" do
    VCR.use_cassette("list-channel-endpoint") do
      workspace = WorkSpace.new
     
      # expect(workspace.select_channel).must_equal "slack-cli"
      # expect(workspace.select_channel.member_count).must_equal ["UV5KWEASY", "UV5KNL1UL", "UV66MLLSH", "UV66H40LV"]
      # expect(workspace.select_channel..slack_id).must_equal "CV5KNMDKN"
      # expect(workspace.select_channel.name).must_equal "slack-cli"
    
    end
  end
end

