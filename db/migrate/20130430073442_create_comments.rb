class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.text :comment_text
      t.integer :note_id

      t.timestamps
    end
  end
end
