#!/usr/bin/env ruby
require_relative 'workspace'


def display_options
  puts "\nEnter one of the following options."
  puts "1. list users"
  puts "2. list channels"
  puts "3. select user"
  puts "4. select channel"
  puts "5. details"
  puts "6. send message"
  puts "0. quit"
end

def get_id_name(recipient)
  puts "To select a #{recipient}, please enter a Slack ID or name:"
  user_input = gets.chomp
  return user_input
end

def prompt_message
  puts "Enter the message you want to send out:"
  user_input = gets.chomp
  return user_input
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  # TODO project
  control_loop = true

  while control_loop
    display_options
    choice = gets.chomp
    case choice
      when "1", "list users"
        tp workspace.users, :slack_id, :name, :real_name
      when "2", "list channels"
        tp workspace.channels, :slack_id, :name, :topic, :member_count
      when "3", "select user"
        # user_input = get_id_name("user")
        begin
          chosen = workspace.select_user
        rescue ArgumentError => exception
          puts "Encountered an error: #{exception}"
        end
      when "4", "select channel"
        # user_input = get_id_name("channel")
        begin
          chosen = workspace.select_channel
        rescue ArgumentError => exception
          puts "Encountered an error: #{exception}"
        end
      when "5", "details"
        if workspace.selected != nil
          begin
            workspace.show_details
          rescue StandardError => exception
            puts "Encountered an error: #{exception}"
          end
        else
          puts "There is no recipient selected. Please select a user or channel first."
        end
      when "6", "send message"
        if workspace.selected != nil
          begin
            workspace.send_message
          rescue StandardError => exception
            puts "Encountered an error: #{exception}"
          end
        else
          puts "There is no recipient selected. Please select a user or channel first."
        end
      when "0", "quit", "exit"
        control_loop = false
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME
