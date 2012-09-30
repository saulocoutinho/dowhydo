class User < ActiveRecord::Base
  
  has_many :topics
  has_many :arguments
  has_many :topic_votes, :dependent => :destroy
  has_many :argument_votes, :dependent => :destroy
  
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id", :dependent => :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  # Include default devise modules. Others available are:
  #  :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def is_my_friend?(user)
    self.friends.exists?(user.id) || self.inverse_friends.exists?(user.id)
  end
  
end
