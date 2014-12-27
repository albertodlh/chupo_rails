class MainController < ActionController::Base
  layout 'application'
  def index
    @main_article = Article.find_by(tag: "main")
    @video_article = Article.find_by(tag: "video")
    @extra_article = Article.find_by(tag: "extra")
    @videos = Video.all
  end
end
