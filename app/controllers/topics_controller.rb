class TopicsController < ApplicationController

  skip_before_filter :authenticate_user!, :only => [:index, :show, :trends]
  skip_before_filter :cors_set_access_control_headers, :only => [:index, :trends, :show]
  
  load_and_authorize_resource :only => :destroy

  respond_to :json, :html

  # POST /topics/:topic_id/do
  # Votar em um topico
  # Um voto por usuário em cada topico
  # Se o voto não existir ele será criado
  # Se o voto já existir ele será alterado para Do caso seja Don't
  # Cada voto incrementa o count do tópico
  # Cada novo voto ou alteração muda o campo updated_at do topico votado
  def doo
    if TopicVote.exists?(['topic_id = ? AND user_id = ?', params[:topic_id], current_user.id])
      vote = TopicVote.where(['topic_id = ? AND user_id = ?', params[:topic_id], current_user.id]).first
      if not vote.kind == 1
        vote.kind = 1
        vote.save
        topic = Topic.find(params[:topic_id])
        topic.updated_at = Time.now
        topic.save
      end
    else
      vote = TopicVote.new
      vote.topic_id = params[:topic_id]
      vote.user_id = current_user.id
      vote.kind = 1
      vote.save
      
      topic = Topic.find(params[:topic_id])
      topic.count += 1
      topic.save
    end
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :ok }
    end
  end
  
  # POST /topics/:topic_id/dont
  # Votar em um topico
  # Um voto por usuário em cada topico
  # Se o voto não existir ele será criado
  # Se o voto já existir ele será alterado para Don't caso seja Do
  # Cada voto incrementa o count do tópico
  # Cada novo voto ou alteração muda o campo updated_at do topico votado
  def dont
    if TopicVote.exists?(['topic_id = ? AND user_id = ?', params[:topic_id], current_user.id])
      vote = TopicVote.where(['topic_id = ? AND user_id = ?', params[:topic_id], current_user.id]).first
      if not vote.kind == 0
        vote.kind = 0
        vote.save
        topic = Topic.find(params[:topic_id])
        topic.updated_at = Time.now
        topic.save
      end
    else
      vote = TopicVote.new
      vote.topic_id = params[:topic_id]
      vote.user_id = current_user.id
      vote.kind = 0
      vote.save
      
      topic = Topic.find(params[:topic_id])
      topic.count += 1
      topic.save
    end
    
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.json { head :ok }
    end  
  end
  
  # GET /topics
  # GET /topics.json
  # Se o usuario estiver logado, apresenta seus tópicos ordenados pela criação
  # Se o usuario não estiver logado, redireciona para Trends
  def index
    if user_signed_in?
      user = User.find(current_user.id)
      @topics = user.topics.order('updated_at DESC')
      
    respond_to do |format|
      format.html
      format.json { render :json => @topics }
      format.js { render :json => @topics.to_json, :callback => params[:callback] }
    end

      #respond_with @topics
    else
      redirect_to trends_topics_url
    end
  end
  
  # GET /topics/trends
  # Apresenta os 10 tópicos com mais votos Do/Dont em ordem decrescente
  def trends
    @topics = Topic.order('count DESC').limit(10)
    
    respond_to do |format|
      format.html
      format.json { render :json => @topics }
      format.js { render :json => @topics.to_json, :callback => params[:callback] }
    end

    #respond_with @topics
  end
  
  
  # GET /topics/1
  # GET /topics/1.json
  # Topico com todos os argumentos ordenados pela data da criação
  def show
    @topic = Topic.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @topic.to_json(:include => [:arguments, :topic_votes]) }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_with @topic
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = current_user.topics.build()
    @topic.title = params[:title]
    @topic.user_id = current_user.id
    @topic.user_email = current_user.email

    respond_to do |format|
      if @topic.save!
        format.html { redirect_to topics_url, :notice => 'topic was successfully created.' }
        format.json { render :json => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.json { render :json => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end
 
  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :ok }
    end
  end
end
