class Line < ActiveRecord::Base
  attr_accessible :author, :content, :story_id
  belongs_to :story
end
