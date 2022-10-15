class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :reviews, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  has_one_attached :profile_image
  
  def get_profile_image
   (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  

  # is_deletedがfalseならtrueを返す
  def active_for_authentication?
   super && (is_deleted == false)
  end

  # ゲストユーザー用
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "guest"
      customer.first_name = "user"
    end
  end

  # 会員フルネーム
  def full_name
    self.last_name + " " + self.first_name
  end
end
