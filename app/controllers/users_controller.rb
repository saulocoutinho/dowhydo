class UsersController < ApplicationController
  
  respond_to :json, :html
  
  def show
    @user = User.find(params[:id])
  
    respond_with @user
  end  
end