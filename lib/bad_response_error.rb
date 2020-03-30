module Slack
  class BadResponseError < StandardError
    def initialize(msg="Slack API endpoint is NOT OK.")
      super
    end
  end
end