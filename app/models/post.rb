class Post < ApplicationRecord
  belongs_to :customer
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_comments, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :body
    validates :price
    validates :image
  end

  def get_post_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end

  def self.ransackable_attributes(auth_object = nil)
    ["title", "price", "star", "created_at"]
  end

  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    #新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end
end
