class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :author
      t.string :title
      t.text :body
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
