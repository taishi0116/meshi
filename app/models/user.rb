class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  has_many :from_messages, class_name: "Message", foreign_key: "fromid", dependent: :destroy
  has_many :invites, foreign_key: "fromid", dependent: :destroy
  has_many :to_messages, class_name: "Message", through: :invites, dependent: :destroy
  
  validates :name, length: {in: 1..15 }, presence: true
  
  devise :database_authenticatable, :rememberable, :trackable, :timeoutable, :omniauthable
         
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    
    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth),
        username: auth.info.nickname,
        name: auth.info.nickname,
        password: Devise.friendly_token[0, 20],
        image: auth.info.image
        )
    end
      
    user
    
  end
  
  def to_param
    username
  end
    
    
  private
  
  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
