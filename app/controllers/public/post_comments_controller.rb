class Public::PostCommentsController < ApplicationController
  before_action :is_matching_login_customer, only: [:destroy]
  def create
    post = Post.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.post_id = post.id
    unless @post_comment.save
      render 'error'
    end
  end

  def destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def is_matching_login_customer
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
  end
end
