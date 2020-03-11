require "test_helper"

describe "Workspace Class" do
  before do
    VCR.use_cassette("workspace_new") do
      @workspace = Workspace.new
    end
  end

  describe "Instantiation" do
    it "creates an instanse of Workspace" do
      expect(@workspace).must_be_kind_of Workspace
    end

    # it "has @users variable which is an empty Array" do
    #   expect(@workspace.users).must_be_kind_of Array
    #   # expect(@workspace.users).must_equal []
    # end

    # it "has @channels variable which is an empty Array" do
    #   expect(@workspace.channels).must_be_kind_of Array
    #   expect(@workspace.channels).must_equal []
    # end

    describe "users" do
      it "is an Array" do
        expect(@workspace.users).must_be_kind_of Array
      end

      it "has Users" do
        expect(@workspace.users[0]).must_be_kind_of User
      end

      it "one of the users is Slackbot" do
        count = 0
        @workspace.users.each do |user|
          count += 1 if user.slack_id == "USLACKBOT"
        end
        expect(count).must_equal 1
      end
    end
  end
end