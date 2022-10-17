class Book < ApplicationRecord
  belongs_to :customer
  has_many :book_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  # throughを利用して、tag_mapsを通してtagsとの関連付け（中間テーブル）
  has_many :tags, through: :tag_maps
  
  has_one_attached :image
  
  validates :title, presence: true
  validates :body, presence: true
  validates :rate, presence: true
  
  def get_image
   (image.attached?) ? image : 'no_image.jpg'
  end
  
  def save_tags(tags)
    
    tag_list = tags.split(/[[:blank:]]+/)
    current_tags = self.tags.pluck(:name)
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags
    p current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
  end
  
   new_tags.each do |new|
      new_book_tag = Tag.find_or_create_by(name: new)
      self.tags << new_book_tag
    end
  end
  
end
