require_relative "test_helper"

describe "Wave1" do
  describe "initialize" do 
    it "can create new instance of Workspace" do
      VCR.use_cassette("workspace-endpoint") do
        response = Workspace.new

        expect(response).must_be_kind_of Workspace
        expect(response.users).must_be_kind_of Array
        expect(response.channels).must_be_kind_of Array
        expect(response.users[0]).must_be_kind_of User 
        expect(response.channels[0]).must_be_kind_of Channel 
      end
    end
  end
  describe "select_channel" do 
    it "select an valid channel" do
      VCR.use_cassette("workspace-endpoint") do
        response = Workspace.new
        search_term = "slack-api"

        selected = nil
        response.select_channel(search_term)
        response.channels.each do |channel|
          if channel.name == search_term
            selected = channel
          end
        end
        
        expect(selected).must_be_kind_of Channel
        expect(selected.slack_id).must_equal "CV649DWUV"
        expect(selected.name).must_equal "slack-api"
        expect(selected.member_count).must_equal 6
      end
    end

    it "select an invalid channel" do
      VCR.use_cassette("workspace-endpoint") do
        response = Workspace.new
        search_term = "invalid_channel"

        selected = nil
        result = response.select_channel(search_term)
        expect(selected).must_equal nil
        expect(result).must_be_kind_of String
        expect(result).must_equal "Sorry, I couldn't find that channel."
      end
    end
  end 

  describe "select_user" do
    it "select a user" do 
      VCR.use_cassette("workspace-endpoint") do
        response = Workspace.new
        search_term = "tithvorlakmok"
        selected = nil
        response.select_user(search_term)
        response.users.each do |user|
          if user.name == search_term
            selected = user
          end
        end
        expect(response.select_user(search_term)).must_be_kind_of String
        expect(selected).must_be_kind_of User
        expect(selected.real_name).must_equal "Lak"
        expect(selected.status_emoji).must_equal ""
        expect(selected.status_text).must_equal ""
        expect(selected.name).must_equal "tithvorlakmok"

      end
    end 

    it "select an invalid user" do
      VCR.use_cassette("workspace-endpoint") do
        response = Workspace.new
        search_term = "invalid_user"
        selected = nil
        result = response.select_user(search_term)
        expect(selected).must_equal nil
        expect(result).must_be_kind_of String
        expect(result).must_equal "Sorry, I couldn't find that user."
      end
    end
  end  
end






  
 
  