require 'twilio-ruby'
require 'sinatra'

class Elevator < ApplicationRecord
    belongs_to :column, optional: true
    after_update :after_updated_elevator
    after_update :send_sms

    def after_updated_elevator
        if $SlackClient and self.saved_change_to_Status? then
           $SlackClient.chat_postMessage(channel: "#elevator_operations", text: "#{self.ElevatorType} Elevator #{self.Model} #{self.SerialNumber} Updated Info\nStatus: #{self.Status}", as_user: true)
        end
    end

    def send_sms()
        if (self.saved_change_to_Status? && self.Status == "Intervention")
            
            account_sid = ENV['TWILIO_ACCOUNT_SID']
            auth_token = ENV['TWILIO_AUTH_TOKEN']
            client = Twilio::REST::Client.new(account_sid, auth_token)

            from = '+19412412411' # Your Twilio number
            to = '+15149958192' # Your mobile phone number

            client.messages.create(
                from: from,
                to: to,
                body: "The status of elevator #{self.id} with serial number #{self.SerialNumber} has changed to Intervention!"
            )
        end
    end 
end
