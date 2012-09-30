class ArgumentVotesController < ApplicationController

  respond_to :json, :html
  skip_before_filter :cors_set_access_control_headers

  # GET /arguments/:argument_id/votes
  # GET /arguments/:argument_id/votes.json
  # Retorna todos os votos daquele argumento contendo apenas o campo user_id.
  # Assim é possível extrair os usuários que votaram
  def index
    argument = Argument.find(params[:argument_id])
    @argument_votes = argument.argument_votes.select(:user_id)

    respond_with @argument_votes
  end
  
end