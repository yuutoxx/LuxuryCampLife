class Post < ApplicationRecord
  belongs_to :customer
  #has_many :post_comments, dependent :destroy
  has_one_attached :image

  def get_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end

  def add_tax_price
    (self.price * 1.10).round
  end
end
