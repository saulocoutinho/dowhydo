class FriendshipsController < ApplicationController

  skip_before_filter :cors_set_access_control_headers, :only => [:index, :friends]

  load_and_authorize_resource :only => [:create, :destroy]
  
  respond_to :json, :html

  def create
    if not current_user.is_my_friend?(User.find(params[:friend_id]))
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      if @friendship.save
        flash[:notice] = "Added friend."
        redirect_to user_url(params[:friend_id])
      else
        flash[:error] = "Unable to add friend."
        redirect_to user_url(params[:friend_id])
      end
    else
      flash[:error] = "Unable to add friend. You're already friends."
      redirect_to user_url(params[:friend_id])
    end
  end
  
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to(:back)
  end
  
  def index
    @friendships = current_user.friendships + current_user.inverse_friendships 
    
    respond_with @friendships
  end

  def friends
    @friendships = current_user.friendships.includes(:friend)
    @inverse_friendships = current_user.inverse_friendships.includes(:user)

    @users = []

    @friendships.each do |f|
      @users << f.friend
    end

    @inverse_friendships.each do |f|
      @users << f.user
    end     
    
    #sort @users DESC by 'name'
    @users.sort! { |a,b| a.email <=> b.email }

    respond_to do |format|
      format.json { render :json => @users }
      format.js { render :json => @users.to_json, :callback => params[:callback] }
    end
  end
end