class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :post_comments, dependent: destroy
  has_one_attached :profile_image

  def get_profile_image(width,height)
    image.variant(resize_to_limit: [width,height]).processed
  end
end
