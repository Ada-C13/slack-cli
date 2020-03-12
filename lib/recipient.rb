class Recipient
  # Generator
  attr_reader :slack_id, :name

  # Constructor
  def initialize

  end

  def send_message(message)

  end

  def self.get(url, params)

  end

  def details
    return "" # No details here, define in sub-class
  end

  def self.list_all
    return [] # No details here, define in sub-class
  end

end # Class
