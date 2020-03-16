require_relative "test_helper"

describe "Workspace" do
  it "Workspace has a list of users and channels" do
    VCR.use_cassette("list_all_users") do
      workspace = Workspace.new
      expect(workspace.users).must_be_kind_of Array
      expect(workspace.users[0]).must_be_instance_of User
      expect(workspace.channels).must_be_kind_of Array
      expect(workspace.channels[0]).must_be_instance_of Channel
      expect(workspace.selected).must_be_nil
    end
  end

  describe "select_user" do
    it "Should return user when given the user name" do
      VCR.use_cassette("list_all_users") do
        workspace = Workspace.new
        my_user = "mairheshmati"
        selection = workspace.select_user(my_user)
        expect(selection).must_be_instance_of User
        expect(selection.name).must_equal "mairheshmati"
        expect(selection.slack_id).must_equal "UV68KR96Z"
        expect(selection.real_name).must_equal "Mair Bear"
      end
    end
    it "Should return user when given the slack ID" do
      VCR.use_cassette("list_all_users") do
        workspace = Workspace.new
        my_slack_id = "UV64BM5QV"
        selection = workspace.select_user(my_slack_id)
        expect(selection).must_be_instance_of User
        expect(selection.name).must_equal "vnikki13"
        expect(selection.slack_id).must_equal "UV64BM5QV"
        expect(selection.real_name).must_equal "Nikki Vaughan"
      end
    end
    it "Should return nil if no such User exists" do
      VCR.use_cassette("list_all_users") do
        workspace = Workspace.new
        bogus_slack_name = "but why"
        selection = workspace.select_user(bogus_slack_name)
        expect(selection).must_be_nil
      end
    end
    it "Should assign that user as selected" do
      VCR.use_cassette("list_all_users") do
        workspace = Workspace.new
        my_user = "mairheshmati"
        workspace.select_user(my_user)
        expect(workspace.selected).must_be_instance_of User
      end
    end
  end
  describe "select_channel" do
    it "Should return channel when given channel name" do
      VCR.use_cassette("uses_get_url") do
        workspace = Workspace.new
        my_channel = "general"
        selection = workspace.select_channel(my_channel)
        expect(selection).must_be_instance_of Channel
        expect(selection.name).must_equal "general"
        expect(selection.slack_id).must_equal "CV5GLCW12"
        expect(selection.topic).must_equal "Company-wide announcements and work-based matters"
        expect(selection.member_count).must_equal 5
      end
    end
    it "Should return channel when given channel slack ID" do
      VCR.use_cassette("uses_get_url") do
        workspace = Workspace.new
        my_channel_id = "CV5GLDJ9J"
        selection = workspace.select_channel(my_channel_id)
        expect(selection).must_be_instance_of Channel
        expect(selection.name).must_equal "slack-bot"
        expect(selection.slack_id).must_equal my_channel_id
        expect(selection.topic).must_equal "A place for us to test our slack API projects"
        expect(selection.member_count).must_equal 5
      end
    end
    it "Should return nil if no such channel exists" do
      VCR.use_cassette("uses_get_url") do
        workspace = Workspace.new
        bogus_channel = "part people?"
        selection = workspace.select_channel(bogus_channel)
        expect(selection).must_be_nil
      end
    end
    it "should assign that channel as selected" do
      VCR.use_cassette("uses_get_url") do
        workspace = Workspace.new
        my_channel = "general"
        workspace.select_channel(my_channel)
        expect(workspace.selected).must_be_instance_of Channel
      end
    end
  end
  describe "details_of" do
    it "Should return the selected item's details/attributes" do
      VCR.use_cassette("uses_get_url") do
        workspace = Workspace.new
        workspace.select_user("mairheshmati")
        my_details = workspace.details_of
        expect(my_details).must_equal "Slack name: mairheshmati\nSlack ID: UV68KR96Z\nReal name: Mair Bear"
      end
    end
  end
  describe "text_me" do
    it "Should send a HTTParty post request to send a message" do
      VCR.use_cassette("send_message") do
        workspace = Workspace.new
        selected = workspace.select_user("mairheshmati")
        request = workspace.text_me("Hello world")

        expect(request).wont_equal false
      end
    end
    it "Should raise an Exception when no message and/or no channel is given" do
      VCR.use_cassette("send_message") do
        workspace = Workspace.new
        selected = nil
        expect { selected.send_message(nil, "hello world") }.must_raise Exception
      end
    end
  end
end
