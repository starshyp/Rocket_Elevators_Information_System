require "ibm_watson"
require "ibm_watson/text_to_speech_v1"

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)

  ################## IBM WATSON ##################
  # authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
  #   apikey: ENV['IBM_WATSON_API_KEY'],
  # )
  #
  # watson_text_to_speech = IBMWatson::TextToSpeechV1.new(
  #   authenticator: authenticator
  # )
  #
  # watson_text_to_speech.service_url = 'https://api.us-east.text-to-speech.watson.cloud.ibm.com/instances/cb2a4acd-d5f1-43e3-bfa0-402b2d7c6934'
  # user = User.find(:current_user)
  # #puts JSON.pretty_generate(text_to_speech.list_voices.result)
  # File.new("output.wav", "w+") do |audio_file|
  #   response = watson_text_to_speech.synthesize(
  #     text: "Hello world!",
  #     accept: "audio/wav",
  #     voice: "en-US_AllisonVoice"
  #   ).result
  #   audio_file << response
  # end

  ################## IBM WATSON ##################

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
