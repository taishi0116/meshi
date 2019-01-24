class Invite < ApplicationRecord
    
    has_many :to_messages, class_name: "Message", foreign_key: "toid"
    belongs_to :user, foreign_key: "fromid"
    
    validates :content, length: { in: 1..90 }, presence: true
    validates :title, length: {in: 1..24 }, presence: true
    
end
