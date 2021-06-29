# class TwilioClient
#     attr_reader :client
#     def initialize
#         @client = Twilio::REST::Client.new account_sid, auth_token
#     end

#     def send_text(user, message)
#         client.api.account.message.create(
#             to: '+5149958192',
#             from: phone_number,
#             body: message
#         )
#     end

#     private 

#     def account_sid
#         Rails.application.credentials.twilio[:account_sid]
#     end

#     def auth_token
#         Rails.application.credentials.twilio[:auth_token]
#     end

#     def phone_number
#         Rails.application.credentials.twilio[:phone_number]
#     end
# end

# @client.messages.create(
#   from: '+14159341234',
#   to: '+15149958192',
#   body: 'Hey world!'
# )