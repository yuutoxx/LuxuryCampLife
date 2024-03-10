class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  has_many :post_comments, dependent :destroy

  def get_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end
end
