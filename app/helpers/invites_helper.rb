module InvitesHelper
   
    class InvitesHelper
        require 'mini_magick'
        require 'securerandom'

        #content
        BASE_IMAGE_PATH1 = './app/assets/images/i.png'.freeze
        GRAVITY1 = 'center'.freeze
        TEXT_POSITION1 = '0,200'.freeze
        FONT1 = './app/assets/fonts/genjyuubold.ttf'.freeze
        FONT_SIZE1 = 30
        INDENTION_COUNT1 = 11
        ROW_LIMIT1 = 8
        
        #title
        GRAVITY2 = 'center'.freeze
        TEXT_POSITION2 = '0,0'.freeze
        FONT2 = './app/assets/fonts/genjyuubold.ttf'.freeze
        FONT_SIZE2 = 60
        INDENTION_COUNT2 = 11
        ROW_LIMIT2 = 8

        class << self
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
        end
    end
end
