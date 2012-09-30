class ArgumentVote < ActiveRecord::Base
  
  belongs_to :argument
  belongs_to :user
  
  validates_presence_of :user_id, :argument_id
  
  #attr_accessible :title, :body
end
