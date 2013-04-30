class Post < ActiveRecord::Base
  attr_accessible :author, :content, :when
end
