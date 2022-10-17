class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      #タグの名前
      t.string :name 

      t.timestamps
    end
  end
end
