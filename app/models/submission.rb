class Submission < ActiveRecord::Base
  attr_accessible :author, :content, :story_id, :vote
  belongs_to :story
  scope :by_vote, order: "vote DESC"
end
