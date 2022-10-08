class Book < ApplicationRecord
  belongs_to :customer
  has_many :reviews, dependent: :destroy
end
