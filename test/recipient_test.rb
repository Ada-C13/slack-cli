require_relative 'test_helper.rb'

describe "Recipient" do
  before do 
    @slack_id = "CV8KPL19U"
    @new_recipient = Recipient.new(@slack_id)
  end
  it "can initialize Recipient with slack id" do
    
    expect(@new_recipient).must_be_kind_of Recipient
    expect(@new_recipient.slack_id).must_equal @slack_id
  end

  describe "send_message method" do 

    it "properly sends a slack message with the message passed as argument" do
      response = nil
      message = "testing the send message method"

      VCR.use_cassette("send_message") do
        response = @new_recipient.send_message(message)
      end

      expect(response).must_be_kind_of HTTParty::Response
      expect(response["ok"]).must_equal true
      expect(response["channel"]).must_equal @slack_id
      expect(response["message"]["text"]).must_equal message
    end

  end

end