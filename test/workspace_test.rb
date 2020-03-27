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

  describe "select_user" do
    it "select a user" do 
      VCR.use_cassette("list-user-endpoint") do
        response = WorkSpace.new
        search_term = "Slackbot"
        selected = User.new(real_name: "Slackbot", status_text: "", status_emoji: "", name: "slackbot", slack_id: "USLACKBOT")

        response.users.each do |user|
          if user.name == search_term || user.slack_id == search_term
            selected = user
          end
        end
        expect(response.select_user(search_term)).must_be_kind_of String
        expect(selected).must_be_kind_of User
        expect(selected.real_name).must_equal "Slackbot"
        expect(selected.status_emoji).must_equal ""
        expect(selected.status_text).must_equal ""
        expect(selected.name).must_equal "slackbot"
      end
    end 

    it "select invalid user" do 
      VCR.use_cassette("list-user-endpoint") do
        response = WorkSpace.new
        search_term = "++++"
        selected = nil

        response.users.each do |user|
          if user.name == search_term || user.slack_id == search_term
            selected = user
          end
        end
        expect(response.select_user(search_term)).must_be_kind_of String
        expect(selected).must_be_nil 
      end
    end 
  end

  describe "select_channels" do
    it "select channels" do 
      VCR.use_cassette("list-channel-endpoint") do
        response = WorkSpace.new
        search_term = "random"
        selected = nil

        response.channels.each do |channel|
          if channel.name == search_term || channel.slack_id == search_term
            selected = channel
          end
        end
        expect(response.select_channel(search_term)).must_be_kind_of String
        expect(selected).must_be_kind_of Channel
        expect(selected.member_count).must_equal 5
        expect(selected.slack_id).must_equal "CV63MEZTJ"
        expect(selected.name).must_equal "random"
      end
    end 

    it "selects invalid channel" do 
      VCR.use_cassette("list-channel-endpoint") do
        response = WorkSpace.new
        search_term = "++++++"
        selected = nil

        response.channels.each do |channel|
          if channel.name == search_term || channel.slack_id == search_term
            selected = channel
          end
        end
        expect(response.select_channel(search_term)).must_be_kind_of String
        expect(selected).must_be_nil
      end
    end 
  end
end

