class Api::CommentsController < ApplicationController
  def index
    if params[:limit]
      @comments = Comment.all.order(pubdate: :desc).limit(params[:limit])
    else
      @comments = Comment.all.order(pubdate: :desc)
    end
    render json: @comments
  end

  def show
    @comment = Comment.where(id: params[:id])
    render json: @comment
  end

  #def new
  #  @comment = Comment.new
  #end

  def create
    if (params[:comment][:email] != 'albertodlh@gmail.com')
      @comment = Comment.new(comment_params)
      if @comment.save
        render plain: 'success'
      else
        errorlist = ""
        @comment.errors.full_messages.each do |msg|
          errorlist += msg + " - "
        end
        render plain: errorlist
      end
    else
      render plain: "That's not really your email address, is it? -.-"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:user, :email, :website, :content)
    end
end
