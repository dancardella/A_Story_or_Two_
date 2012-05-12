class Submission < ActiveRecord::Base
  attr_accessible :user_id, :content, :story_id, :vote
  belongs_to :user
  belongs_to :story
  scope :by_vote, order: "vote DESC"
  validates_presence_of :content
end
