class Message < ApplicationRecord
    belongs_to :invite, foreign_key: "toid"
    belongs_to :from_user, class_name: "User", foreign_key: "fromid"
    
    validates :content, length:{ in: 1..100 }, presence: true
end
