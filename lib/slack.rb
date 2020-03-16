require "table_print"
require "gemoji-parser"
require_relative "workspace"

def get_selected
  user_selected = ""
  until user_selected != ""
    puts "Enter the slack id or name of the channel/user:"
    user_selected = gets.chomp
  end

  return user_selected
end

def get_message_text
  user_message = ""
  until user_message != ""
    puts "Enter your message:"
    user_message = gets.chomp
  end

  return user_message
end

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = Workspace.new
  puts "Your workspace has #{workspace.channels.length} channels and #{workspace.users.length} users."

  i = -1
  while i < 0
    puts
    puts "What would you like to do? (Enter the number.)\n"
    puts " 1: list channels \n 2: list users \n 3: select a channel or user \n 4: show details of selected channel/user \n 5: send message \n 6: quit"
    puts "----------"
    option_choice = gets.chomp.downcase
    case option_choice
      when "1"
        # table_print all channels
        tp workspace.channels, "slack_id", "name", "member_count", "topic"
      when "2"
        # table_print all users
        tp workspace.users, "slack_id", "name", "real_name", "status_text", "status_emoji"
      when "3"
        # update @selected and confirm with message
        user_input = get_selected
        if workspace.select(user_input)
          selected_recipient = workspace.select(user_input)
          recipient_type = selected_recipient.class == Channel ? "channel" : "user"
          puts "The #{recipient_type} named '#{selected_recipient.name}' is currently selected."
        else
          puts "No matching slack credentials found."
        end
      when "4"
        # show details of selected recipient
        if workspace.selected
            puts workspace.selected.details
        else
          puts "No recipient selected."
        end
      when "5"
        # send a message to selected recipient and confirm
        if workspace.selected
          text_to_send = get_message_text
          puts workspace.selected.slack_id
          workspace.selected.send_message(text_to_send)
          puts "Message sent!"
        else
          puts "No recipient selected."
        end
      when "6"
        # quit
        i = 1
    end
  end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME