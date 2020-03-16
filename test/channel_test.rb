require_relative "test_helper"
require_relative "../lib/channel"

describe "Channel class" do
  describe "initialize" do
    before do
      @chan_inst = Channel.new(
        name: "stuff",
        slack_id: "THISISANID",
        topic: "This is a channel to talk about stuff.",
        member_count: "3"
      )
    end
    it "is an instance of Channel" do
      expect(@chan_inst).must_be_kind_of Channel
    end
  end

  describe "list_all" do
    it "creates an array of channels" do
      VCR.use_cassette("list_channels_endpoint") do
        channels = Channel.list_all

        expect(channels).wont_be :empty?
        expect(channels).must_be_kind_of Array
        expect(channels[0]).must_be_kind_of Channel
      end
    end

    describe "self.get" do
      it "gets a list of channels from the api" do
        list = {}
        VCR.use_cassette("list_channels_endpoint") do
          list = Channel.get("https://slack.com/api/conversations.list")
        end
        
        expect(list).must_be_kind_of HTTParty::Response
        expect(list["ok"]).must_equal true
      end

      it "raises an error when the api call fails" do
        VCR.use_cassette("list_channels_endpoint") do
          expect {Channel.get("https://slack.com/api/bogus.call")}.must_raise SlackAPIError
        end
      end
    end
  end
end

# Any tests involving a Channel should use the #random channel

# EXAMPLE DATA

# "channels": [
#   {
#       "id": "CV5KRSHJQ",
#       "name": "general",
#       "is_channel": true,
#       "is_group": false,
#       "is_im": false,
#       "created": 1583868608,
#       "is_archived": false,
#       "is_general": true,
#       "unlinked": 0,
#       "name_normalized": "general",
#       "is_shared": false,
#       "parent_conversation": null,
#       "creator": "UUT9Z80AE",
#       "is_ext_shared": false,
#       "is_org_shared": false,
#       "shared_team_ids": [
#           "TV63QKAAU"
#       ],
#       "pending_shared": [],
#       "pending_connected_team_ids": [],
#       "is_pending_ext_shared": false,
#       "is_member": false,
#       "is_private": false,
#       "is_mpim": false,
#       "topic": {
#           "value": "Company-wide announcements and work-based matters",
#           "creator": "UUT9Z80AE",
#           "last_set": 1583868608
#       },
#       "purpose": {
#           "value": "This channel is for workspace-wide communication and announcements. All members are in this channel.",
#           "creator": "UUT9Z80AE",
#           "last_set": 1583868608
#       },
#       "previous_names": [],
#       "num_members": 5
#   },
#   {
#       "id": "CV649DWUV",
#       "name": "slack-api",
#       "is_channel": true,
#       "is_group": false,
#       "is_im": false,
#       "created": 1583868609,
#       "is_archived": false,
#       "is_general": false,
#       "unlinked": 0,
#       "name_normalized": "slack-api",
#       "is_shared": false,
#       "parent_conversation": null,
#       "creator": "UUT9Z80AE",
#       "is_ext_shared": false,
#       "is_org_shared": false,
#       "shared_team_ids": [
#           "TV63QKAAU"
#       ],
#       "pending_shared": [],
#       "pending_connected_team_ids": [],
#       "is_pending_ext_shared": false,
#       "is_member": false,
#       "is_private": false,
#       "is_mpim": false,
#       "topic": {
#           "value": "",
#           "creator": "",
#           "last_set": 0
#       },
#       "purpose": {
#           "value": "",
#           "creator": "",
#           "last_set": 0
#       },
#       "previous_names": [],
#       "num_members": 7
#   },