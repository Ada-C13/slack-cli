require 'httparty'

module Slack
  class Recipient

    attr_reader :id, :name

    def initialize(id, name)
      @id = id
      @name = name
    end

    def load_all
      raise NotImplementedError.new("Implement me in a child class!")
    end

    def details
      raise NotImplementedError.new("Implement me in a child class!")
    end

    def send_message
      raise NotImplementedError.new("Implement me in a child class!")
    end

  end
end