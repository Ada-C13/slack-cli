class Recipient
  attr_reader :slack_id, :name
  
  def initialize(slack_id, name)
    #self.class.validate_id(id) <== this is what was in CSV record
    @slack_id = slack_id
    @name = name
  end
  
  def valid_name
    
  end
  
  def valid_slack_id
    
  end
  
  # def send_message(message)
  
  # end
  
  
  # def self.get(url, params)
  
  # end
  
  # def self.load_all(full_path: nil, directory: nil, file_name: nil)
  #   full_path ||= build_path(directory, file_name)

  #   return CSV.read(
  #     full_path,
  #     headers: true,
  #     header_converters: :symbol,
  #     converters: :numeric
  #   ).map { |record| from_csv(record) }
  # end
  
  # def details
  
  # end
  
  
  # def self.list_all
  
  # end
  
end