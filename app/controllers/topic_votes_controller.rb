class TopicVotesController < ApplicationController

  skip_before_filter :cors_set_access_control_headers
  
  respond_to :json, :html

  # GET /topics/:topic_id/votes
  # GET /topics/:topic_id/votes.json
  # Retorna todos os votos daquele topico contendo apenas os campos kind e user_id.
  # Assim é possível extrair os usuários que votaram.
  def index
    topic = Topic.find(params[:topic_id])
    @topic_votes = topic.topic_votes.select([:kind, :user_id])

    respond_with @topic_votes
  end
end