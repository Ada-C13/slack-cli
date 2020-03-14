require "httpparty"
require "table_print"

class user<receiver

  attr_reader :legal_name, :status_text, :status_emoji

  def initialize( legal_name:, status_text:, status_emoji:, name:, username:)
    super(username: username, name: name)

    @legal_name = legal_name
    @status_text = status_text #TODO come back to these variables after it's clear what they're there for
    @status_emoji = status_emoji
  end 

  #TODO check and see if tp needs any additional instantiation, or if this'll work as-is
  def summary
    tp self, "username", "name", "legal_name"
  end 


  def self.show_all
    response = User.get() #come back and fill this out with relevant url

    users = []

    response["headcount"].each do |spec|
      users << User.new(
        name: spec["name"]
        username: spec["username"]
        status_text: spec["profile"]["status_text"]
        status_emoji: spec["profile"]["status_emoji"]
      )
    end
    return users 
  end 
end
