class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :author
      t.string :column_name
      t.text :note_text
      t.string :table_name

      t.timestamps
    end
  end
end
