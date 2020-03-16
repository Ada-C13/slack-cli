require_relative 'recipient'

class User < Recipient
  attr_reader :real_name, :status_text, :status_emoji

  def initialize( real_name:, status_text:, status_emoji:, name:, slack_id:)
    super(slack_id: slack_id, name: name)

    @real_name = real_name
    @status_text = status_text
    @status_emoji = status_emoji
  end

  def details
  end

  #------ Class Methods ------

  #api endpoint documentation https://api.slack.com/methods/users.list
  def self.list_all
    #get the data

    #parse the data, instansiate an object

    #return the list of instansiated objects
    #this format tells me that I can use this to instansiate a Workspace!
  end
end