class TopicVote < ActiveRecord::Base
  
  belongs_to :topic
  belongs_to :user
  
  validates_presence_of :kind, :topic_id, :user_id
  validates_inclusion_of :kind, :in => 0..1
  
  # attr_accessible :title, :body
end
