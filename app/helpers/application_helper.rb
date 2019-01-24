module ApplicationHelper
      
    def get_twitter_card_info(invite)
        twitter_card = {}
        if invite
            twitter_card[:url] = 'https://meshi-go.herokuapp.com/<%= invite.user.username %>/invites/<%= invite.id %>/messages/new'
            twitter_card[:title] = '<%= invite.user.username %>の投稿'
            twitter_card[:description] = '<%= invite.content %>'
            twitter_card[:image] = 'https://s3.amazonaws.com/meshi-image/<%= invite.user.username %>/<%= invite.id %>.png'
        else
            twitter_card[:url] = 'X'
            twitter_card[:title] = 'X'
            twitter_card[:description] = 'X'
            twitter_card[:image] = 'X'
        end
            twitter_card[:site] = '@dtb6464'
            twitter_card
    end 
end
