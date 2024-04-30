class Public::PostsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_search
  before_action :ensure_correct_customer, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.score = Language.get_data(post_params[:body]) #感情分析
    @post.customer_id = current_customer.id
    # 受け取った値を、で区切って配列にする
    tag_list = params[:tag][:name].split('、')
    if tags_valid?(tag_list) && @post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿が完了しました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render 'index'
    end
  end

  def index
    @post = Post.new
    @posts = Post.all.order(params[:sort]).page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_comment = PostComment.new
    if @post_comment.save
      redirect_to post_path(@post)
    else
      render 'show'
    end
  end

  def edit
  # 編集対象の投稿に関連付けられたタグを取得し、、区切りの文字列に変換してフォームに渡す
  @post_tag_names = @post.tags.pluck(:name).join('、')
  end

  def update
    @post.score = Language.get_data(post_params[:body]) #感情分析
    tag_list = params[:tag][:name].split('、')
    if tags_valid?(tag_list) && @post.update(post_params)
      @post.tags.destroy_all
      @post.save_tags(tag_list)
      redirect_to post_path(@post), notice: "投稿を更新しました。"
    else
      flash.now[:notice] = "投稿に失敗しました。"
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
    @posts= @tag.posts.page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, :price, :star)
  end

  def set_search
    @q = Post.ransack(params[:q])
    @posts = @q.result.order(params[:sort]).page(params[:page]).per(5)
  end

  def ensure_correct_customer
    @post = Post.find(params[:id])
    unless @post.customer == current_customer
      redirect_to posts_path
    end
  end

  def tags_valid?(tags)
    # タグが重複しているかどうかをチェック
    tags.uniq.size == tags.size
  end
end
