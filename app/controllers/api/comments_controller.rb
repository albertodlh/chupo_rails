class Api::CommentsController < ApplicationController
  def index
    if params[:limit]
      @comments = Comment.all.order(:pubdate).limit(params[:limit])
    else
      @comments = Comment.all.order(:pubdate)
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
    @comment = Comment.new(comment_params)
    if @comment.save
      render plain: 'success'
      #redirect_to @comment
    else
      errorlist = ""
      @comment.errors.full_messages.each do |msg|
        errorlist += msg
      end
      render plain: errorlist
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:user, :email, :website, :content)
    end
end
