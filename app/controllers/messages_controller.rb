class MessagesController < ApplicationController
    
    before_action :correct_user, only: [:index, :show]
    
    def new
        @user = User.find_by(username: params[:user_username])
        @invite = @user.invites.find_by(id: params[:invite_id])
        @message = @invite.to_messages.new
    end
    
    def create
        @user = User.find_by(username: params[:user_username])
        @invite = @user.invites.find_by(id: params[:invite_id])
        @message = current_user.from_messages.new(message_params)
        if @message.save
            flash[:success] = 'メッセージを送信しました'
            redirect_to user_invite_message_created_index_path(message_id: @message.id)
        else
            render "new"
        end
    end
    
    def show
        @user = User.find_by(username: params[:user_username])
        @invite = Invite.find_by(id: params[:invite_id], fromid: @user.id)
        @message = Message.find_by(id: params[:id], toid: params[:invite_id])
        @message.boolean = 'true'
        @message.save
        @message_user = User.find(@message.fromid)
    end
    
    # messges#indexで2つのviewを描画する
    
    def index
        @user = User.find_by(username: params[:user_username])
        @invite = Invite.find_by(id: params[:invite_id], fromid: @user.id)
        @invites = Invite.where(fromid: @user.id)
        @messages = @user.to_messages.order(id: "DESC")
        
        if params[:invite_id].present?
            @invite_messages = Message.where(toid: @invite.id).order(id: "DESC")
        end
        
    end
    
    private
    
    def message_params
        params.require(:message).permit(:content, :toid)
    end
    
    def correct_user
      @user = User.find_by(username: params[:user_username])
      redirect_to(root_url) unless @user == current_user
    end
    
end
