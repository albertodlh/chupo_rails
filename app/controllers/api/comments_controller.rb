class Api::CommentsController < ApplicationController
  def index
    if params[:limit]
      comments = Comment.all.order(pubdate: :desc).limit(params[:limit])
    else
      comments = Comment.all.order(pubdate: :desc)
    end
    resp = {
      meta: {
        resource_name: 'comments',
        count: comments.length
      },
      data: comments
    }
    render plain: resp.to_json
  end

  def show
    @comment = Comment.where(id: params[:id])
    render json: @comment
  end

  #def new
  #  @comment = Comment.new
  #end

  def create
    resp = {
      success: false,
      data: '',
      errors: ''
    }
    if (params[:comment][:email] != 'albertodlh@gmail.com')
      comment = Comment.new(comment_params)
      if comment.save
        resp[:success] = true
        resp[:data] = comment
        render plain: resp.to_json
      else
        resp[:errors] = comment.errors.full_messages
        render plain: resp.to_json
      end
    else
      resp[:errors] = ["That's not really your email address, is it? -.-"]
      render plain: resp.to_json
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:user, :email, :website, :content)
    end
end
