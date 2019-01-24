class CreatedController < ApplicationController
  def index
    @user = User.find_by(username: params[:user_username])
  end
end
