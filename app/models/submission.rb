class Submission < ActiveRecord::Base
  attr_accessible :user_id, :content, :story_id, :vote
  belongs_to :user
  belongs_to :story
  scope :by_vote, order: "vote DESC"
  validates_presence_of :content
end


def create_submission
  submission = Submission.new :content => params[:submission][:content], :story_id => params[:id], :vote => 0
  if submission.save
  flash[:save_notice] = "Thanks for submitting!"
  redirect_to story_url
  else
    flash[:alert] = "Not so fast...try again?"
    redirect_to story_url
  end
end
