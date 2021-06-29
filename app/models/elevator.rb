class Elevator < ApplicationRecord
    belongs_to :column

    after_update :after_updated_elevator

    def after_updated_elevator
        if $SlackClient and self.saved_change_to_Status? then
            
            $SlackClient.chat_postMessage(channel: '#elevator_operations', text: "#{self.ElevatorType} Elevator #{self.Model} #{self.SerialNumber} Updated Info\nStatus: #{self.Status}", as_user: true)
        end
    end
end
