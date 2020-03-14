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

  it "returns false when message is not sent to user" do
    user = nil
    selected = nil
    sending_message = nil
    VCR.use_cassette("chat.postMessage") do
      data = {'id' => '1234',
        'name' => 'bot',
        'real_name' => 'testbot',
        'profile' => {'status_text' => 'test text',
        'status_emoji' => ':test:'}}
    
      user = SlackCLI::User.new(data)  
      recipients = [user]
      workspace = SlackCLI::Workspace.new
      selected = workspace.select(recipients, '1234')
      sending_message = workspace.send_message("test")
    end
    expect(selected).must_equal user
    expect(sending_message).must_equal false
  end

  it "returns false when message is not sent to channel" do
    channel = nil
    selected = nil
    sending_message = nil
    VCR.use_cassette("chat.postMessage") do
      data = {'id' => '1234',
        'name' => 'bot',
        'topic' => {'value' => 'test text'},
        'num_members' => '100'}
    
      channel = SlackCLI::Channel.new(data)  
      recipients = [channel]
      workspace = SlackCLI::Workspace.new
      selected = workspace.select(recipients, '1234')
      sending_message = workspace.send_message("test")
    end
    expect(selected).must_equal channel
    expect(sending_message).must_equal false
  end
end