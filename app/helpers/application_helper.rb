module ApplicationHelper
      
    def get_twitter_card_info(invite)
    twitter_card = {}
    if invite
      twitter_card[:url] = "https://meshi-go.herokuapp.com/#{invite.user.username}/invites/#{invite.id}/messages/new"
      twitter_card[:title] = "#{invite.title}・@#{invite.user.username}の投稿"
      twitter_card[:description] = "#{invite.content}"
      twitter_card[:image] = "https://s3.amazonaws.com/meshi-image/#{invite.user.username}/#{invite.id}.png"
    else
      twitter_card[:url] = "https://meshi-go.herokuapp.com/"
      twitter_card[:title] = 'Meshi'
      twitter_card[:description] = 'Twitterで気軽にご飯に誘えるサービスです'
      twitter_card[:image] = 'https://data.ac-illust.com/data/thumbnails/b1/b1ce57f717a88f1d9e5e49375c99b4ce_w.jpeg'
    end
      twitter_card
    end 
end
