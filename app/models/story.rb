class Story < ActiveRecord::Base
  attr_accessible :title
  has_many :lines
  has_many :submissions
end

def create_story
  story = Story.new
  story.title = "testing more"
  story.save
end