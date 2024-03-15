class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_search

  def index
    @posts = Post.all.order(params[:sort])
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end

  def search_tag
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts= @tag.posts
    @tag_list = Tag.all
  end

  private

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result.order(params[:sort])
  end
end
