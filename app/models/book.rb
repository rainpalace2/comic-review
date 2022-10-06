class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  self.primary_key = "isbn"

# 点数の平均値を出すメソッド
  def avg_score
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f
    else
      0.0
    end
  end

# 点数をパーセンテージ化するメソッド
  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:score).round(1).to_f*100/5
    else
      0.0
    end
  end
end
