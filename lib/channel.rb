require 'HTTParty'
require 'dotenv'
require_relative 'workspace'
require_relative 'slack'
require_relative 'user'
require_relative 'recipient'

Dotenv.load

# Recipient contains:
#list
#select
#show_detail
#send_message

class Channel < Recipient





end