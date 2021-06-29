require 'twilio-ruby'

account_sid = ENV["TWILIO-ACCOUNT"]
auth_token = ENV["TWILIO-TOKEN"]
client = Twilio::REST::Client.new(account_sid, auth_token)

from = '+19412412411' # Your Twilio number
to = '+15149958192' # Your mobile phone number

client.messages.create(
    from: from,
    to: to,
    body: "Hello world!"
)
