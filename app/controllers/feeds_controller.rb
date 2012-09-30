class FeedsController < ApplicationController

  skip_before_filter :cors_set_access_control_headers

  respond_to :json

  def index
    friendships = current_user.friendships.includes(:friend => [:arguments, :topics])
   	inverse_friendships = current_user.inverse_friendships.includes(:user => [:arguments, :topics])

   	@news = []
    @news = current_user.arguments + current_user.topics

    friendships.each do |f|
    	@news << f.friend.arguments + f.friend.topics       
    end

    inverse_friendships.each do |f|
      @news << f.user.arguments + f.user.topics
    end

    #flatten removes nodes from array
    @news.flatten!

    #sort @news DESC by 'created_at'
    @news.sort! { |a,b| b.created_at <=> a.created_at }

  	respond_to do |format|
      format.json { render :json => @news }
      format.js { render :json => @news.to_json, :callback => params[:callback] }
    end
  end

  def userfeed
    if params[:user_id].present?
      user = User.find(params[:user_id])

      @news = []
      @news << user.arguments
      @news << user.topics

      #flatten removes nodes from array
      @news.flatten!

      #sort @news DESC by 'created_at'
      @news.sort! { |a,b| b.created_at <=> a.created_at }

      respond_to do |format|
        format.json { render :json => @news }
        format.js { render :json => @news.to_json, :callback => params[:callback] }
      end
    else
      @news = []
      @news << current_user.arguments
      @news << current_user.topics

      #flatten removes nodes from array
      @news.flatten!

      #sort @news DESC by 'created_at'
      @news.sort! { |a,b| b.created_at <=> a.created_at }


      respond_to do |format|
        format.html
        format.json { render :json => @news }
        format.js { render :json => @news.to_json, :callback => params[:callback] }
      end
    end
  end
end