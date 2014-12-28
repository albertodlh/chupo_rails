class MainController < ActionController::Base
  layout 'application'
  def index
    @main_article = Article.find_by(tag: "main")
    @video_article = Article.find_by(tag: "video")
    @extra_article = Article.find_by(tag: "extra")
    @videos = Video.all
  end

  def twitter
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "vW7kzwS9TJ6bjVkuMr9gQueEt"
      config.consumer_secret     = "bcOvdZ8oEJl8YyEBTIMtL6qzgsDeGk9OLGAvXWYPAlQpjo36CR"
      config.access_token        = "42718258-0d5vbkYq7STwRKb6kXV0hUnqLVTO52CuJ46zivo20"
      config.access_token_secret = "IZI0GCY3H5hF9AaUL6VQxZuE1A7RTN4mQZNJeyQtt570f"
    end

    api_tweets = client.search("boto el chupo -rt").take(10)

    tweets = []

    api_tweets.each do |api_tweet|
      tweet = {}
      tweet[:name] = api_tweet.user.name
      tweet[:username] = api_tweet.user.screen_name
      tweet[:avatar] = api_tweet.user.profile_image_url.to_s #.sub(/_normal./, '.')
      tweet[:location] = api_tweet.user.location
      tweet[:date] = api_tweet.created_at
      tweet[:text] = api_tweet.text
      tweets.push tweet
    end

    render plain: tweets
  end
end
