class Public::HomesController < ApplicationController
  def top
    @posts = Post.all
    puts"作成したキー #{ENV['SECRET_KEY']}"
  end

  def about
  end
end
