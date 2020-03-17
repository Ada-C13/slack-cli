require_relative 'channel'
require_relative 'user'
require 'table_print'
require 'json'


module SlackCli

    class Workspace 

        attr_reader :users, :channels
        attr_accessor :selected

        def initialize(users:,channels:,selected:)
            @users = SlackCli::User.list_all
            @channels = SlackCli::Channel.list_all
            @selected = nil
        end

        def select_channel
            puts "here's a list of all channels available!"
            tp self.channels.map{|channel| channel}, "slack_id","name"
            puts "which channel would you like to select? or q to return to the previous menu!"
            selected_cli = gets.chomp
            if selected_cli == "q"
                main
            else 
                selection = find_id_or_name(channels,selected_cli)
                if selection == true
                    puts "you selected #{selected.name}"
                else 
                    puts "#{selected_cli} is not a valid user! try again!"
                    select_channel
                end
            end
        end

        def select_user
            puts "here's a list of all users available!"
            tp self.users.map{|user| user}, "slack_id","name"
            puts "which user would you like to select? or q to return to the previous menu!"
            selected_cli = gets.chomp
            if selected_cli == "q"
                main
            else 
                selection = find_id_or_name(users,selected_cli)
                if selection == true
                puts "you selected #{selected.name}"
                else 
                    puts "#{selected_cli} is not a valid user! try again!"
                    select_user
                end
            end
        end

        def find_id_or_name(items,string)
            items.each do |item|
                if item.slack_id.include?(string.upcase) || item.name.include?(string.downcase)
                    @selected = item
                    return true
                end
            end 
            return false
        end

        def show_details
            tp selected.details
            # return selected.details
        end

        def send_message
            if @selected != nil
                puts "would you like to send a message to the previously selected user/channel? type previous to continue or type q to return to the previous menu"
                puts "or would you like to select a new user/channel?"
                selection = gets.chomp
                if selection == "q"
                    return
                elsif selection == "user"
                    select_user
                elsif selection == "channel"
                    select_channel
                elsif selection == "previous"
                    puts "you'll be sending a message to #{selected.name}"
                else 
                    puts "wrong input! try again!"
                end
            else
                puts "would you like to send a message to a user or a channel?"
                selection = gets.chomp
                if selection == "user"
                    select_user
                elsif selection == "channel"
                    select_channel
                else 
                    puts "wrong input! try again!"
                end
            end

            puts "Type a message you'd like to send to #{selected.name}? or type q to return to the previous menu"
            message = gets.chomp
            if message == "q" || message == " "
                return
            else
                selected.send_message(message)
            end
        end
    end
end 