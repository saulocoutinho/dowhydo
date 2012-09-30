class Topic < ActiveRecord::Base
  
  belongs_to :user
  has_many :topic_votes, :dependent => :destroy
  has_many :arguments, :dependent => :destroy
  
  validates_presence_of :title, :count, :user_id
  
  attr_accessible :title
  
  
  # Cria array o argumento WHY mais votado e o argumento WHY NOT mais votado
  # Chamado nas views ao renderizar a partial 'arguments/main'
  def main
    @arguments = [ self.arguments.where(:kind => 1).order('count DESC').first ,
                   self.arguments.where(:kind => 0).order('count DESC').first ]
    
    return @arguments
  end
end
