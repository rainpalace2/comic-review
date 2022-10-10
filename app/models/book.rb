class Book < ApplicationRecord
  belongs_to :customer
  has_many :book_comments, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true
  
end
