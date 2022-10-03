class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reviews, dependent: :destroy
  
  # is_deletedがfalseならtrueを返す       
  def active_for_authentication?
   super && (is_deleted == false)
  end
end
