require 'HTTParty'
require 'dotenv'
require_relative 'workspace'
require_relative 'channel'
require_relative 'slack'
require_relative 'recipient'

Dotenv.load

# Recipient contains:
#list
#select
#show_detail
#send_message

class User < Recipient





end