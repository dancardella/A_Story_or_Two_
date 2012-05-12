# TO DO:
# Call me Ishmael
# Refactor Controller into models/views/helpers
# Build collection of story lines to insert into the first line of newly created stories. 


class StoryController < ApplicationController
  
  def index
    @stories = Story.all
    @story = Story.find_by_id(params[:id])
  end
  
  def new
    
  end
  
  def create
    submission = Submission.new
    submission.content = params[:submission][:content]
    submission.story_id = params[:id]
    submission.vote = 0
    if submission.save
      flash[:save_notice] = "Thanks for submitting!"
      redirect_to story_url
    else
      flash[:alert] = "Not so fast...try again?"
      redirect_to story_url
    end
    
  end
  
  def show
    @story = Story.find_by_id(params[:id])
    @lines = Line.find_all_by_story_id(params[:id])
    @submissions = Submission.by_vote.find_all_by_story_id(params[:id])
    @new_submission = Submission.new
    
    
    # Starting to repeat a bit, maybe this can be done a better way.
    
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

    if @vote_total == 9
      @newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      @newline = @newlines.first
      line = Line.new
      line.content = @newline.content
      line.story_id = params[:id]
      line.save
      Submission.scoped({:conditions => ['story_id = ?', params[:id] ]}).destroy_all
      redirect_to story_url
    elsif Submission.find_all_by_story_id(params[:id]).empty?
      #FLASH NOTICE
      redirect_to story_url
    else
      @submission = Submission.find_by_id(params[:submission_id])
      @submission.vote += params[:vote_count].to_i
      @submission.save
      redirect_to story_url
    end
  end

end