require 'httparty'
require 'dotenv'

module SlackCli
  
  class Recipient

    attr_reader :slack_id, :name

    def initialize(slack_id,name)
      @slack_id = slack_id
      @name = name 
    end

    def self.get_all
    end 

  end
end 