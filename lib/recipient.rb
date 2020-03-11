class Recipient
  
  KEY = ENV["SLACK_TOKEN"]

  def initialize(slack_id, name)
    @slack_id = slack_id
    @name = name
  end

  # to list all the users and channels
  def self.list_all
    raise NotImplementedError, 'Implement me in a child class!'
  end



end