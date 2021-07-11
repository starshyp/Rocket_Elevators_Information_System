# Readme for the Rocket Elevators website at http://rtrocketelevator.xyz/

<Details>
<summary>SendGrid API</summary>

### What is SendGrid?

SendGrid provides a cloud-based service that assists businesses with email delivery.

### How to use

Submit a contact form using your email address.

### New gems installed

```bash
gem 'sendgrid-ruby'
gem "figaro"
```

### Implementation
*app/controllers/leads_controller.rb*
```ruby
mail = Mail.new
mail.from = Email.new(email: 'rocketelevator312890+sendgrid@gmail.com')
personalization = Personalization.new
personalization.add_to(Email.new(email: @lead.Email))
#personalization.add_to(Email.new(email: params[:Email]))
personalization.add_dynamic_template_data({
    "FullName" => @lead.FullName,
    "ProjectName" => @lead.ProjectName
    })
mail.add_personalization(personalization)
mail.template_id = 'd-a1170dbad8924f9ba0f038014445e76b'

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
begin
  response = sg.client.mail._("send").post(request_body: mail.to_json)
rescue Exception => e
  puts e.message
end
puts response.status_code
puts response.body
#puts response.parsed_body
puts response.headers
```
*Email preview when someone submits a contact form*

![](https://uc8cb2b4ed7396b17340c665177b.previews.dropboxusercontent.com/p/thumb/ABPWglemUAyJeYg5R4wsWnEPWWyZ_R5Mf0D8LTUad5TP3QOxl0icFttmBloIHpUGQPAphIjaK80oy92F0HG-Owz85QGBEUkBrfYKy_b8JSDZJM4o_uLsoYAZ9co0hXEcciCGDakierbPbciD_1UkxiPUGeZAjGM39zl4he1F1jlkdX4NS5J0qnOLACS_6vPkzeKCNU-eeR9y5YYahxWaFGQf3GhM7FBiFwkEdn7pEKhsB7AMirT7iYIksp-110x5yNfY5eHzZWK4nCoj3AP3gFyiPv2MchbWSPoWaFycXvRL_o1UpHv2Dr3wOSHKFyYd3L-KEl2aZIsdYcxv-zJ49kzz-9WSj_IozXXDqFL7_y6Y49plbrYV3Pgkq56Ovs-Cd_ThA4HpOIv4UJIg7M8LsNEW/p.png)

### Notes
No notes.
</details>

<Details>
<summary>IBM Watson (Text to Speech) API</summary>

### What is IBM Watson (Text to Speech)?

It is an API cloud service that enables you to convert written text into natural-sounding audio in a variety of languages and voices within an existing application.

### How to use

Login to the backoffice with nicolas.genest@codeboxx.biz with password 'codeboxx', click on the 'Audio Brief' tab and click the button to play. Please wait 2-6 seconds for the audio to process and play after clicking the button.

### New gems installed

```bash
gem 'ibm_watson', '~> 2.1', '>= 2.1.1'
gem "figaro"
```

### Implementation
*app/controllers/watson_controller.rb*
```ruby
class WatsonController < ApplicationController
  require "ibm_watson"
  require "ibm_watson/text_to_speech_v1"
  include IBMWatson

  def refreshaudio
    ################## IBM WATSON ##################
    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
      apikey: ENV['TEXT_TO_SPEECH_APIKEY'],
    )
    text_to_speech = IBMWatson::TextToSpeechV1.new(
      authenticator: authenticator
    )
    text_to_speech.service_url = ENV['TEXT_TO_SPEECH_URL'] #/v1/workspaces/
    
    user = Employee.where(user_id: current_user.id).first

    greeting = "Greetings #{user.FirstName} #{user.LastName}. There are currently #{Elevator.count} elevators deployed in #{Building.count} buildings of your #{Customer.count} customers. Currently, #{Elevator.where.not(:Status => "on").count} elevators are not in Running Status and are being serviced. You currently have #{Quote.count} quotes awaiting processing. You currently have #{Lead.count} leads in your contact requests. #{Battery.count} are deployed across #{Address.distinct.count(:City)} cities."

    #puts JSON.pretty_generate(text_to_speech.list_voices.result)
    #File.open("app/assets/audio/watson.mp3", "wb") do |audio_file|
      response = text_to_speech.synthesize(
        text: greeting,
        accept: "audio/mp3",
        voice: "en-GB_JamesV3Voice"
      ).result
      send_data response
    #end
    ################## IBM WATSON ##################
  end

end
```
*lib/watson.rb*
```ruby
module RailsAdmin
  module Config
    module Actions
      class Watson < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :breadcrumb_parent do
          nil
        end

        register_instance_option :route_fragment do
          'watson.html.erb'
        end

        register_instance_option :link_icon do
          'icon-play'
        end

        register_instance_option :statistics? do
          true
        end

      end
    end
  end
end
```
*config/locales/en.yml*
```yml
en:
  admin:
    actions:
      watson:
        title: "IBM Watson"
        menu: "Audio Brief"
        breadcrumb: "Audio Brief"
```

*app/views/rails_admin/main/watson.html.erb*
```javascript
<%= audio_tag "/watson/refreshaudio", class: "audio-play" %>
<p class="btn btn-primary audioButton">Play Briefing</p>

<%= javascript_tag "window._token = '#{form_authenticity_token}'" %>

<script>

    $(".audioButton").on("click", function() {
        $(".audio-play")[0].currentTime = 0;
        return $(".audio-play")[0].play();
    });
</script>
```
*config/routes,rb*
```ruby
get "/watson/refreshaudio", to: "watson#refreshaudio"
```


*Audio briefing in backend preview*
![](https://ucecc5d66f6dbfb17ccf6a128f94.previews.dropboxusercontent.com/p/thumb/ABMEkIJruupz7Z3agPjY-9q1NIijZGxo4fXJKRCGD6jlQSYpD0bso9CsbYeNgXPkj1W8lpC6DUEcbFTsuCxK2gvZe-dXzJAWR8M1Sfn-vgKfmV6VbZFlbK2BYoISFypcXiI_-QXxFTBTladbLfvhUftY1LTI7uKANnZzc7yWJ3zF-pznmPdc-7I9O65ccIOEiTfZot8sG8HxuySFbHdzBLajwkHiDrDcOHCQfzFDDg7Q4YSrG8G7wNHsmpo3rEgQGmUNLbXkjTlQsPzByleApsBJNr7ur5gkP7DOJYA2uu3QROCo6V5W7GeqF8r_reCSOJr6jgqDWfCL05oIRC1Q6UQszRwzD2nZD8but788KL-vduNfHzjozrmVTl7mMp4cqyqwS7O3xEGEtQWJSfXQloB_/p.png)

### Notes
After pressing the 'Play Briefing' button, give it 5 seconds to process and play. Also, after updating the count of a resource (leads, quotes, etc.), go back to the main 'Dashboard' then back to the audio tab and wait 30 seconds before playing the audio again for it to update with the new figures.
</details>


Ruby version : ruby 2.6.6

Rails version: Rails 5.2.6

Important Gems: Cancancan, rails-Admin, Devise, Rolify, Pg & Multiverse.

Databases: MySQL(RayanTaing) & PostgreSQL(RayanTaing_datawarehouse_development).

General MySQL terminal commands concerning the RayanTaing database:
  - ```rails db:drop db:create db:migrate db:seed```

General PostgreSQL terminal commands concerning the RayanTaing_datawarehouse_development database:
  - ```DB=datawarehouse rails db:drop db:create db:migrate db:seed```
    
MySQL Tables: Users, Employees, Roles, Quotes, Leads, Address, Customers, Buildings, BuildingDetails,
    Battery, Columns, Elevators and AddressGeocode.

PostgreSQL Tables: FactQuotes, FactContact, FactElevator & DimCustomers

Seeding: 21 users(with the password of "codeboxx") & employees, 25 quote forms (these quotes are for the purpose of testing the database, the numbers inside do not respect the normal calculations), 10 leads(ContactUs forms),
    100 adresses, 50 customers, 50 building details, 50 buildings; each buildings has 1
    battery  (Total : 50 battery), each battery has 3 columns(Total : 150 columns) & each column has 4 
    elevators (Total : 600 elevators) and a random number of building details between 0 and 5.

Admin of the site: All of the employees of Rocket Elevators havec the admin privileges so it is possible 
    to have access to the Back Office by connecting to their accounts. We used the email adress of nicolas.genest@codeboxx.biz with password codeboxx to test the website.

Back Office ONLY visible to admins.

Data transfer from MySQL to PostgreSQL is done through a rake task : - ```rails dwh:import```

For all the data transfers and making the right relationships for the transfers, the ":import" rake task 
    has been used.

For the three .SQL files, you can use this syntax while in the "current" folder of "RayanTaing" in the Codeboxx server : psql codeboxx -h codeboxx-postgresql.cq6zrczewpu2.us-east-1.rds.amazonaws.com -d RayanTaing_datawarehouse_development -f QuoteRequest.sql

# Whats new

Admins Dashboard
  - Audio briefing provided By IBM Watson 
  - Maps For geolocating our "Customers" provided by Gmaps4rails

Contact Us sections sends to 
  - ZenDesk API a Question Ticket
  - Dropbox API with a provided attached file
  - SendGrid API with a Thank you Email to the user

Updating Elevator Status to ``"Intervention"`` sends a message to 
  - Slack Rocket Elevator Server in #elevator_operations
  - Sends a SMS to a Targeted number set in ``"application.yml"`` using Twilio API
  
To try the code, you have to start the server log into the Rocket Elevators website and click on  “back office” in the top navigation bar. You would then have to select the elevators tab in the navigation section and select a random elevator. The final step would be to edit the status and change it to “intervention”.
