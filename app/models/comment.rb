class Comment < ActiveRecord::Base
  attr_accessible :author, :comment_text, :note_id
  belongs_to :note
end
