class Story < ActiveRecord::Base
  attr_accessible :title
  has_many :lines
  has_many :submissions
end

def create_story
  story = Story.new
  @new_stories = NewStory.all
  @new_stories = @new_stories.shuffle
  @new_story = @new_stories.first
  story.title = @new_story.title
  story.save
  line = Line.new
  line.story_id = story.id
  line.content = @new_story.content
  line.save
end