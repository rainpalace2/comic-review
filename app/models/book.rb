class Book < ApplicationRecord
  belongs_to :customer
  has_many :book_comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  # throughを利用して、tag_mapsを通してtagsとの関連付け（中間テーブル）
  # Book.tagsで、Bookに紐づけられたTagの取得が可能
  has_many :tags, through: :tag_maps
  
  has_one_attached :image
  
  validates :title, presence: true
  validates :body, presence: true
  validates :rate, presence: true
  
  def get_image
   (image.attached?) ? image : 'no_image.jpg'
  end
  
  def save_tags(tags)
    # タグをスペース区切りで分割し配列にする
    # 連続した空白にも対応する、最後の"+"がポイント
    tag_list = tags.split(/[[:blank:]]+/)
    
    # 自分自身に関連づいたタグを取得する
    current_tags = self.tags.pluck(:name)
    
    # (1) 元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    # Book更新時に削除されたタグ
    old_tags = current_tags - tag_list
    
    # (2) 投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    # 新規に追加されたタグ
    new_tags = tag_list - current_tags
    
    p current_tags
    
    # tag_mapsテーブルから、(1)のタグを削除
    # tagsテーブルから該当のタグを探し出して削除する
    old_tags.each do |old|
      # tag_mapsテーブルにあるbook_idとtag_idを削除
    　# 後続のfind_byでtag_idを検索
      self.tags.delete Tag.find_by(name: old)
  end
  
    # tagsテーブルから(2)のタグを探して、tag_mapsテーブルにtag_idを追加する
    # 条件のレコードを初めの1件を取得し1件もなければ作成する
   new_tags.each do |new|
      new_book_tag = Tag.find_or_create_by(name: new)
      # tag_mapsテーブルにbook_idとtag_idを保存
      # 配列追加のようにレコードを渡すことで新規レコードが作成される
      self.tags << new_book_tag
    end
  end
  
end
