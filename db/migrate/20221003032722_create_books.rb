class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books, id: false do |t|
      t.bigint :isbn, null: false, primary_key: true
      t.string :title
      t.string :author
      t.integer :size
      t.string :booksGenreId
      t.text :item_caption
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end
end
