class Argument < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :topic
  has_many :argument_votes, :dependent => :destroy
  
  validates_presence_of :arg, :count, :kind, :topic_id, :user_id
  VALID_WHY = %w( why whynot )
  validates_inclusion_of :kind, :in => VALID_WHY, :message => 'why ou whynot'
  
  attr_accessible :arg, :kind
  
end
