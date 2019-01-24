class UsersController < ApplicationController
  require "rmagick"
  include Magick
  
  before_action :redirect_force, only: [:index]
  before_action :correct_user, only: [:show, :update, :edit]
  
  def show
    @user = User.find_by(username: params[:username])
  end

  def index
    
  end
  
  def edit
    @user = User.find_by(username: params[:username])
  end
  
  def update
    @user = User.find_by(username: params[:username])
    if current_user == @user
 
      if @user.update(user_params)
        flash[:success] = 'ニックネームを変更しました'
        redirect_to root_url
      else
        render :edit
      end   
 
    else
      redirect_to root_url
    end
  end
  
  def redirect_force
    redirect_to user_path(current_user.username)
  end
  
  def correct_user
      @user = User.find_by(username: params[:username])
      redirect_to(root_url) unless @user == current_user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name)
  end
end