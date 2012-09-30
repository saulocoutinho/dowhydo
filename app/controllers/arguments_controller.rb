class ArgumentsController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:why, :whynot, :main, :index]
  skip_before_filter :cors_set_access_control_headers, :only => [:why, :whynot, :main, :index]
  
  load_and_authorize_resource :only => :destroy
  
  respond_to :json, :html
  
  # POST /arguments/:argument_id/vote
  # Votar em um argumento
  # Um voto por usuário em cada argumento
  # Se o voto não existir ele será criado e o contador será incrementado
  # Se o voto já existir ele será apagado e o contador será decrementado
  def vote
    if Argument.exists?(params[:argument_id])
      if ArgumentVote.exists?(['argument_id = ? AND user_id = ?', params[:argument_id], current_user.id])
        vote = ArgumentVote.where(['argument_id = ? AND user_id = ?', params[:argument_id], current_user.id]).first
        vote.destroy
        
        argument = Argument.find(params[:argument_id])
        argument.count -= 1
        argument.save
      else
        argument_vote = ArgumentVote.new
        argument_vote.argument_id = params[:argument_id]
        argument_vote.user_id = current_user.id
        argument_vote.save
        
        argument = Argument.find(params[:argument_id])
        argument.count += 1
        argument.save
      end
      respond_to do |format|
        format.html { redirect_to(:back) }
        format.json { head :ok}
      end
    end
  end
 
  # GET /topics/:topic_id/arguments/why
  # GET /topics/:topic_id/arguments/why.json
  # Apresenta os argumentos do tipo Why daquele topico
  # ordenados pelo numero de votos em ordem decrescente
  def why
    topic = Topic.find(params[:topic_id])
    @arguments = topic.arguments.where(:kind => 1).order('count DESC')
    
    respond_with @arguments
  end
  
  # GET /topics/:topic_id/arguments/whynot
  # GET /topics/:topic_id/arguments/whynot.json
  # Apresenta os argumentos do tipo WhyNot daquele topico
  # ordenados pelo numero de votos em ordem decrescente
  def whynot
    topic = Topic.find(params[:topic_id])
    @arguments = topic.arguments.where(:kind => 0).order('count DESC')
    
    respond_with @arguments    
  end
  
  # GET /topics/:topic_id/arguments/main
  # GET /topics/:topic_id/arguments/main.json
  # Apresenta o ultimo argumento
  # Apresenta o argumento mais votado do tipo Why
  # Apresenta o argumento mais votado do tipo WhyNot 
  def main
    topic = Topic.find(params[:topic_id])
    @arguments = []
    @arguments << topic.arguments.last
    @arguments << topic.arguments.where(:kind => 1).order('count DESC').first
    @arguments << topic.arguments.where(:kind => 0).order('count DESC').first
    
    respond_with @arguments
  end

  def index
    if params[:topic_id].present?
      topic = Topic.find(params[:topic_id])
      @arguments = topic.arguments

      respond_to do |format|
        format.html
        format.json { render :json => @arguments }
        format.js { render :json => @arguments.to_json, :callback => params[:callback] }
      end
    else
      respond_to do |format|
        format.html
        format.json { render :json => '' }
        format.js { render :json => ''.to_json, :callback => params[:callback] }
      end
    end
  end

  # POST /arguments
  # POST /arguments.json
  def create
    @topic = Topic.find(params[:topic_id])

    @argument = current_user.arguments.build()
    @argument.arg = params[:argument]
    @argument.kind = params[:kind]
    @argument.user_email = current_user.email
    @argument.topic_id = @topic.id
    @argument.title = @topic.title
    @argument.topic_user_id = @topic.user_id
    @argument.topic_user_email = @topic.user_email
      
    if @argument.save!
      @topic.updated_at = Time.now
      @topic.save
      
      respond_to do |format|
        format.html { redirect_to topic_path(params[:topic_id]), :notice => 'Argument was successfully created.' }
        format.json { head :ok }
        #format.json { render :json => @argument, :status => :created, :location => @argument }
      end
    else
      respond_to do |format|
        format.html { render :action => "new" }
        format.json { render :json => @argument.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arguments/1
  # DELETE /arguments/1.json
  def destroy
    @argument = Argument.find(params[:id])
    @argument.destroy

    respond_to do |format|
      format.html { redirect_to topic_path(params[:topic_id]) }
      format.json { head :ok }
    end
  end
end
