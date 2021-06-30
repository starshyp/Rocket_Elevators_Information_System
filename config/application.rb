require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rocket
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    if ENV["SLACK_API_TOKEN"] then
      Slack.configure do |config|
        config.token = ENV["SLACK_API_TOKEN"]
        $SlackClient = Slack::Web::Client.new
      end
    end

    require 'zendesk_api'
    require 'oauth2'

    $zenclient = ZendeskAPI::Client.new do |config|
      config.url = "https://rocketelevator312891.zendesk.com/api/v2"
      config.retry = true
      
      config.logger = true
      config.username = "rocketelevator312890@gmail.com"

      config.token = ENV["ZENDESK_TOKEN"]
      config.access_token = ENV["ZENDESK_AUTH_TOKEN"]
    end
  end
end
