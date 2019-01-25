class InvitesController < ApplicationController

    before_action :correct_user, only: [:new, :show, :index]
    after_action  :meta_data_twitter, only: [:show]
    
    helper_method :meta_data_twitter
    
    
    def new
        @user = User.find_by(username: params[:user_username])
        @invite = @user.invites.new
    end
    
    def create
        @user = User.find_by(username: params[:user_username])
        @invite = @user.invites.new(invite_params)
        if @invite.save
            build1(@invite.content)
            build2(@invite.title)
            @username = User.find(@invite.fromid).username
            uploader = ImageUploader.new(@invite, @username)
            uploader.store!(@image)
            flash[:success] = '投稿を作成しました'
            redirect_to user_invite_path(id: @invite.id)
        else
            render "new"
        end
    end
    
    def show
        @user = User.find_by(username: params[:user_username])
        @invite = Invite.find_by(id: params[:id], fromid: @user.id)
        @message = Message.new
    end
    
    def index
        @user = User.find_by(username: params[:user_username])
        @invites = @user.invites.order(id: "DESC")
    end




    #ここから下はmini_magickのコード
    
    require 'mini_magick'
    require 'securerandom'

    #content
    BASE_IMAGE_PATH1 = './app/assets/images/i.png'.freeze
    GRAVITY1 = 'center'.freeze
    TEXT_POSITION1 = '0,100'.freeze
    FONT1 = './app/assets/fonts/genjyuubold.ttf'.freeze
    FONT_SIZE1 = 35
    INDENTION_COUNT1 = 18
    ROW_LIMIT1 = 5
        
    #title
    GRAVITY2 = 'center'.freeze
    TEXT_POSITION2 = '0,-110'.freeze
    FONT2 = './app/assets/fonts/genjyuubold.ttf'.freeze
    FONT_SIZE2 = 55
    INDENTION_COUNT2 = 13
    ROW_LIMIT2 = 2

        
    # 合成後のFileClassを生成 content
    def build1(text)
        text = prepare_text1(text)
        @image = MiniMagick::Image.open(BASE_IMAGE_PATH1)
        configuration1(text)
    end
            
    # title
    def build2(text)
        text = prepare_text2(text)
        configuration2(text)
    end

    # title
    def write2(text)
        build2(text)
        @image.write uniq_file_name
    end
            

    private

    # uniqなファイル名を返却 content
    def uniq_file_name
        "#{SecureRandom.hex}.png"
    end

    # 設定関連の値を代入 content
    def configuration1(text)
        @image.combine_options do |config|
        config.font FONT1
        config.gravity GRAVITY1
        config.pointsize FONT_SIZE1
        config.draw "text #{TEXT_POSITION1} '#{text}'"
        end
    end

    # 背景にいい感じに収まるように文字を調整して返却 content
    def prepare_text1(text)
        text.scan(/.{1,#{INDENTION_COUNT1}}/)[0...ROW_LIMIT1].join("\n")
    end
            
    # title
    def configuration2(text)
        @image.combine_options do |config|
        config.font FONT2
        config.gravity GRAVITY2
        config.pointsize FONT_SIZE2
        config.draw "text #{TEXT_POSITION2} '#{text}'"
        end
    end

    # title
    def prepare_text2(text)
        text.scan(/.{1,#{INDENTION_COUNT2}}/)[0...ROW_LIMIT2].join("\n")
    end
            
    #strong parameters
    def invite_params
        params.require(:invite).permit(:title, :content)
    end
    
    def correct_user
      @user = User.find_by(username: params[:user_username])
      redirect_to(root_url) unless @user == current_user
    end
    
    def meta_data_twitter
        twitter_card[:url] = 'https://meshi-go.herokuapp.com/#{@invite.user.username}/invites/#{@invite.id}/messages/new'
        twitter_card[:title] = '#{@invite.user.username}の投稿'
        twitter_card[:description] = '#{@invite.content}'
        twitter_card[:image] = 'https://s3.amazonaws.com/meshi-image/#{@invite.user.username}/#{@invite.id}.png'
    end
end