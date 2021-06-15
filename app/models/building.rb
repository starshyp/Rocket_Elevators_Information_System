class Building < ApplicationRecord
    belongs_to :user
    has_many :building_details
end
