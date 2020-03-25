require_relative "test_helper"

describe "Recipient class" do

  describe 'Self.list_all' do
    it 'self.list_all' do
      expect{Recipient.list_all}.must_raise NotImplementedError
    end
  end

  it "sending message" do 
    VCR.use_cassette("list-user-endpoint") do
      recipient = Recipient.new(slack_id: "CV63MEZTJ", name: "random")
      response = recipient.send_message("Hi")
      expect(recipient.send_message("Hi")).must_equal true
    end
  end

  it "raises error for invalid user or channel" do 
    VCR.use_cassette("list-user-endpoint") do
      recipient = Recipient.new(slack_id: "CV6J", name: "random")
      expect{recipient.send_message("Hi")}.must_raise SlackAPIError
    end
  end

  describe 'details' do
    it 'details' do
      responde = Recipient.new(slack_id: "jeta", name: "jeta")
      expect{responde.details}.must_raise NotImplementedError
    end
  end
end




