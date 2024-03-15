class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_search
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.customer_id = current_customer.id
    # 受け取った値を、で区切って配列にする
    tag_list = params[:post][:name].split('、')
    if@post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿が完了しました。"
    else
      render 'index'
    end
  end

  def index
    @post = Post.new
    @posts = Post.all.order(params[:sort])
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated post successfully."
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def search_tag
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @posts= @tag.posts
    @tag_list = Tag.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :price, :star)
  end

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to posts_path
    end
  end
end
