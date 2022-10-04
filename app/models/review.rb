class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :book, primary_key: "isbn"
  validates :score, presence: true
end
