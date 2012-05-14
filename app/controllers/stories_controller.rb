class StoriesController < ApplicationController
  
  def index
    @stories = Story.all
    @story = Story.find_by_id(params[:id])
  end
  
  def new
  end
  
  def create
    create_submission
  end
  
  def show
    @stories = Story.all    
    @story = Story.find_by_id(params[:id])
    @lines = Line.find_all_by_story_id(params[:id])
    @submissions = Submission.by_vote.find_all_by_story_id(params[:id])
    @new_submission = Submission.new
    # To display latest story upon completion of previous story. 
    @last_story_id = Story.last.id
  end
  


  def update
    vote_total = 0
    submissions = Submission.find_all_by_story_id(params[:id])
    submissions.each do |submission|
    vote_total += submission.vote 
    end
    
    if session[:vote_time] && (Time.now - session[:vote_time] < 1800)
      flash[:notice] = "Only 1 Vote Per 30-Minutes...Please!" 
      redirect_to story_url and return story_url
    else
      #@submission = Submission.find_by_id(params[:id])
      session[:vote_time] = Time.now    
    end
    
    if vote_total == 9 && Line.find_all_by_story_id(params[:id]).count == 9
      submission_to_line_create_new_story
    elsif vote_total == 9
      submission_to_line
    elsif Submission.find_all_by_story_id(params[:id]).empty? || Submission.find_by_id(params[:submission_id]).nil?
      #FLASH NOTICE
      redirect_to story_url
    else
      submit_vote
    end
  end
end
