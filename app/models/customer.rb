class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true, length: { in: 2..20 }

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  GUEST_CUSTOMER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_CUSTOMER_EMAIL) do |customer|
        customer.password = SecureRandom.urlsafe_base64
        customer.name = 'ゲスト'
      end
    end

    def guest_customer?
      email == GUEST_CUSTOMER_EMAIL
    end
end
