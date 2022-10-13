class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :good, primary_key: "isbn"
  
  validates :score, presence: true
end
