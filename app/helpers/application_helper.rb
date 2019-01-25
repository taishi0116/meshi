module ApplicationHelper
      
    def meta_tag_twitter()
        twitter_card = {}
        if (defined? meta_data_twitter)
            meta_data_twitter
        else
            twitter_card[:url] = 'https://meshi-go.herokuapp.com'
            twitter_card[:title] = 'meshi-go'
            twitter_card[:description] = 'Twitterで気軽にご飯に誘えるアプリです'
            twitter_card[:image] = 'X'
        end
    end 
end
