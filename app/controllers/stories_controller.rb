class StoriesController < ApplicationController
  
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
    
    @vote_total = 10
    @submissions_votes = Submission.find_all_by_story_id(params[:id])
    @submissions_votes.each do |submission|
    @vote_total -= submission.vote 
    @user=User.find_by_id(params[:user_id])
    end

    @last_story_object = Story.last
    @last_story_id = @last_story_object.id

  end
  


  def update
    
      if session[:vote_time] && (Time.now - session[:vote_time] < 3600)
        flash[:notice] = "Only 1 Vote Per Hour...Please!" 
        redirect_to story_url and return story_url
      else
        #@submission = Submission.find_by_id(params[:id])
        session[:vote_time] = Time.now
        @vote_total = 0
        @submissions = Submission.find_all_by_story_id(params[:id])
        @submissions.each do |submission|
        @vote_total += submission.vote 
        end    
      end
     
    if @vote_total == 9 && Line.find_all_by_story_id(params[:id]).count == 9
      @newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      @newline = @newlines.first
      line = Line.new
      line.content = @newline.content
      line.story_id = params[:id]
      line.save
      Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
      create_story
      redirect_to stories_url
   
    elsif @vote_total == 9
      @newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      @newline = @newlines.first
      line = Line.new
      line.content = @newline.content
      line.story_id = params[:id]
      line.save
      Submission.scoped({:conditions => ['story_id = ?', params[:id]]}).destroy_all
      redirect_to story_url
    elsif Submission.find_all_by_story_id(params[:id]).empty? || Submission.find_by_id(params[:submission_id]).nil?
      #FLASH NOTICE
      redirect_to stories_url
    else
      @submission = Submission.find_by_id(params[:submission_id])
      @submission.vote += params[:vote_count].to_i
      @submission.save
      redirect_to story_url
    end
  end
end
