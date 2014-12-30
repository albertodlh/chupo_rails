class MainController < ActionController::Base
  layout 'application'
  def index
    @main_article = Article.find_by(tag: "main")
    @video_article = Article.find_by(tag: "video")
    @extra_article = Article.find_by(tag: "extra")
    @twitter_article = Article.find_by(tag: "twitter")
    @comment_article = Article.find_by(tag: "comment")
    @tweets = get_tweets("boto el chupo -rt", 10)
    @videos = Video.all
  end

  def test
  end

  private
    def get_tweets(search_string, count)
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = "vW7kzwS9TJ6bjVkuMr9gQueEt"
        config.consumer_secret     = "bcOvdZ8oEJl8YyEBTIMtL6qzgsDeGk9OLGAvXWYPAlQpjo36CR"
        config.access_token        = "42718258-0d5vbkYq7STwRKb6kXV0hUnqLVTO52CuJ46zivo20"
        config.access_token_secret = "IZI0GCY3H5hF9AaUL6VQxZuE1A7RTN4mQZNJeyQtt570f"
      end
      api_tweets = client.search(search_string).take(count)
      tweets = []
      api_tweets.each do |api_tweet|
        tweets << {
          name: api_tweet.user.name,
          username: api_tweet.user.screen_name,
          avatar: api_tweet.user.profile_image_url.to_s, #.sub(/_normal./, '.')
          location: api_tweet.user.location,
          date: api_tweet.created_at,
          text: api_tweet.text
        }
      end
      tweets
    end
end
