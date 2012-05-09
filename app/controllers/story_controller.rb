class StoryController < ApplicationController
  
  def index
    @stories = Story.all
  end
  
  def new
    
  end
  
  def create
    @submission = Submission.new
    @submission.content = params[:content]
    @submission.story_id = params[:id]
    @submission.vote = 0
    @submission.save
    redirect_to story_url
   
  end
  
  def show
    @story = Story.find_by_id(params[:id])
    @lines = Line.find_all_by_story_id(params[:id])
    @submissions = Submission.by_vote.find_all_by_story_id(params[:id])
    
    
    # Starting to repeat a bit, maybe this can be done a better way.
    # Either way, this is to display vote-countdown on show pages.
    @vote_total = 9
    @submissions_votes = Submission.find_all_by_story_id(params[:id])
    @submissions_votes.each do |submission|
      @vote_total -= submission.vote
    end
    @vote_total = @vote_total + 1
    
  end
  
  def update
    @vote_total = 0
    @submissions = Submission.find_all_by_story_id(params[:id])
      @submissions.each do |submission|
        @vote_total += submission.vote
      end

    @current_story_id = Story.find(params[:id])

    if @vote_total == 9
      @newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      @newline = @newlines.first
      line = Line.new
      line.content = @newline.content
      line.story_id = @current_story_id.id
      line.save
      @submissions = Submission.find_all_by_story_id(params[:id])
      @submissions.each do |submission|
        submission.destroy
      end
      redirect_to story_url
    else
      @submission = Submission.find_by_id(params[:submission_id])
      @submission.vote += params[:vote_count].to_i
      @submission.save
      redirect_to story_url
    end
    
  end

end