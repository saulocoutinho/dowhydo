class Friendship < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  
  validates_presence_of :friend_id, :user_id
  
  attr_accessible :friend_id
end
