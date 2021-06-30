class Elevator < ApplicationRecord
    belongs_to :column

    before_save :updated_elevator

    def updated_elevator
        if $SlackClient and self.Status_changed? then
            text = "The Elevator #{self.id} with Serial Number #{self.SerialNumber} changed status from #{self.Status_change[0]} to #{self.Status_change[1]}"
            $SlackClient.chat_postMessage(channel: '#elevator_operations', text: text, as_user: true)
        end
    end
end
