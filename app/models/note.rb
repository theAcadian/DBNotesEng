class Note < ActiveRecord::Base
  attr_accessible :author, :column_name, :note_text, :table_name
  has_many :comments
end
