describe "#send_message" do
  it "returns true when message is sent to user" do
    sending_message = nil
    VCR.use_cassette("chat.postMessage") do
      workspace = SlackCLI::Workspace.new
      workspace.select_user('USLACKBOT')
      sending_message = workspace.send_message('Test')
    end
    expect(sending_message).must_equal true 
  end

  it "returns true when message is sent to channel" do
    sending_message = nil
    VCR.use_cassette("chat.postMessage") do
      workspace = SlackCLI::Workspace.new
      workspace.select_channel('random')
      sending_message = workspace.send_message('Test')
    end
    expect(sending_message).must_equal true 
  end

  # edited the post_message cassette request: token=<SLACK_TOKEN>&channel=USLACKBOT&text=BadMessage
  # and changed response to "ok":false,"error":"Error"
  it "throws an error when message is not sent" do
    VCR.use_cassette("chat.postMessage") do
      workspace = SlackCLI::Workspace.new
      workspace.select_user('USLACKBOT')
      expect{workspace.send_message('BadMessage')}.must_raise SlackCLI::Recipient::SlackAPIError 
    end
  end
end