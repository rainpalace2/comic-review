class Tag < ApplicationRecord
  # tag_mapsと関連付けを行い、tag_mapsのテーブルを通しbooksテーブルと関連付け
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  # Tag.booksとすれば、タグに紐付けられたBookを取得できる
  has_many :books, through: :tag_maps
end
