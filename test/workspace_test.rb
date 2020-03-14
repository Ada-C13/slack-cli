require_relative "test_helper"

describe "Workspace class" do
  describe "initialize" do
    it "list all the users" do 
      VCR.use_cassette("list_of_users") do
        users = User.list_all
        expect(users).must_be_kind_of Array
        users.each do |user|
          expect(user).must_be_kind_of User
        end
      end
    end

    it "list all the channels" do
      VCR.use_cassette("list_of_channels") do
        channels = Channel.list_all
        expect(channels).must_be_kind_of Array
        channels.each do |channel|
          expect(channel).must_be_kind_of Channel
        end
      end
    end
  end  

  # describe "select user" do
  #   it "stores the user id to @selected" do
  #     VCR.use_cassette("list_of_users") do
  #       workspace = Workspace.new
  #       workspace.select_user("USLACKBOT")
  #       expect(workspace.selected).must_equal "USLACKBOT"
  #     end
  #   end

  #   it "stores the username to @selected" do
  #     VCR.use_cassette("list_of_users") do
  #       workspace = Workspace.new
  #       workspace.select_user("slackbot")
  #       expect(workspace.selected).must_equal "slackbot"
  #     end
  #   end

  #   it "notify user if the provided user id or username is invalid" do
  #     VCR.use_cassette("list_of_users") do
  #       workspace = Workspace.new
  #       expect(workspace.select_user("xxxxxxxx")).must_equal "User doesn't exist!"
  #     end
  #   end
  # end

  describe "#show_details method" do
  #   it "see user details of the current selected user" do
  #     VCR.use_cassette("list_of_users") do
  #       workspace = Workspace.new
  #       users = User.list_all
  #       @selected = ""
  #       workspace.select_user("slackbot")
  #       details = workspace.show_details(users)
  #       expect(details[0]).must_be_kind_of User
  #       expect(details[0].name).must_equal "slackbot"
  #       expect(details[0].real_name).must_equal "Slackbot"
  #     end
  #   end
  
    it "see channel details of the current selected channel" do
      VCR.use_cassette("list_of_channels") do
        workspace = Workspace.new
        channels = Channel.list_all
        @selected = ""
        workspace.select_channel("CV63MEZTJ")
        details = workspace.show_details(channels)
        expect(details[0]).must_be_kind_of Channel
        expect(details[0].name).must_equal "random"
        expect(details[0].topic).must_be_kind_of Hash
        expect(details[0].member_count).must_equal 4
      end
    end
  end

  describe "select channel" do
    it "stores the channel id to @selected" do
      VCR.use_cassette("list_of_channels") do
        workspace = Workspace.new
        workspace.select_channel("CV63MEZTJ")
        expect(workspace.selected).must_equal "CV63MEZTJ"
      end
    end

    it "stores the channel name to @selected" do
      VCR.use_cassette("list_of_channels") do
        workspace = Workspace.new
        workspace.select_channel("random")
        expect(workspace.selected).must_equal "random"
      end
    end

    it "notify user if the provided channel id or channel name is invalid" do
      VCR.use_cassette("list_of_channels") do
        workspace = Workspace.new
        expect(workspace.select_channel("xxxxxxxx")).must_equal "Channel doesn't exist!"
      end
    end
  end
end