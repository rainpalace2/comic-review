class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :content
      t.float :score
      t.float :rate
      t.references :good, null: false
      t.references :customer, null: false

      t.timestamps
    end
  end
end
