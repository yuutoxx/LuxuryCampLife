class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:show, :edit, :update, :destroy]

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
    @post_new = Post.new
    @posts = Post.all
    @tag_list = Tag.all
  end

  def show
    @tag_list = @post.tags.pluck(:name).join('、')
    @post_tags = @post.tags
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "You have updated book successfully."
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
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :price, :star)
  end

  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to posts_path
    end
  end
end
