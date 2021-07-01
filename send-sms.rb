require 'twilio-ruby'
require 'sinatra'

module Messenger
    class SMS
        def send_sms()
            account_sid = ENV['TWILIO-ACCOUNT']
            auth_token = ENV['TWILIO-AUTH']
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
