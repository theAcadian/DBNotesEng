class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :author
      t.text :content
      t.datetime :when

      t.timestamps
    end
  end
end
