class Book < ApplicationRecord
  belongs_to :customer
  has_many :book_comments, dependent: :destroy
  
  has_one_attached :image
  
  validates :title, presence: true
  validates :body, presence: true
  validates :rate, presence: true
  
  def get_image
   (image.attached?) ? image : 'no_image.jpg'
  end
  
end
