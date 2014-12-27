class MainController < ActionController::Base
  layout 'application'
  def index
    @article = Article.last
  end
end
