class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :user_id
      t.string :text
      t.string :type
      t.string :area
      t.string :day
      t.string :course
      t.string :style
      t.string :pert
      t.string :music
      t.string :genre
      t.string :sound
      t.timestamps
    end
  end
end
