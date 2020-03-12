response = HTTParty.get(BASE_URL, query: {token: SLACK_TOKEN})
channels = []
response['channels'].each do |channel|
  channels << channel['name'] #outputs channels names
end

return channels
