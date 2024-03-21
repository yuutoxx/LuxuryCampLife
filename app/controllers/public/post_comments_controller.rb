class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    comment = current_customer.post_comments.new(post_comment_params)
    comment.post_id = post.id
    unless comment.save
      render 'error'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find(params[:id]).destroy
    #redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
