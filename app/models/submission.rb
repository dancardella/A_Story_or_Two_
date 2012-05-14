class Submission < ActiveRecord::Base
  attr_accessible :user_id, :content, :story_id, :vote
  belongs_to :user
  belongs_to :story
  scope :by_vote, order: "vote DESC"
  validates_presence_of :content
end


def create_submission
  submission = Submission.new :content => params[:submission][:content], :story_id => params[:id], :vote => 0
  @user = User.find_by_id(params[:user_id])
  if submission.save
  flash[:save_notice] = "Thanks for submitting!"
  redirect_to story_url
  else
    flash[:alert] = "Not so fast...try again?"
    redirect_to story_url
  end
end

# To display count-down of votes
def votes_left
  vote_total = 10
  # @submissions = Submission.find_all_by_story_id(params[:id])
  @submissions.each do |submission|
  vote_total -= submission.vote
  end
  vote_total
end

def submit_vote
  submission = Submission.find_by_id(params[:submission_id])
  submission.vote += params[:vote_count].to_i
  submission.save
  redirect_to story_url
end

def submission_to_line
  newlines = Submission.by_vote.find_all_by_story_id(params[:id])
  newline = newlines.first
  line = Line.create :content => newline.content, :story_id => params[:id]
  Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
  redirect_to story_url
end

def submission_to_line_create_new_story
  newlines = Submission.by_vote.find_all_by_story_id(params[:id])
  newline = newlines.first
  line = Line.create :content => newline.content, :story_id => params[:id]
  Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
  create_story
  redirect_to story_url  
end