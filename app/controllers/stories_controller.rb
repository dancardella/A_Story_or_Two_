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
    @stories = Story.all    
    @story = Story.find_by_id(params[:id])
    @lines = Line.find_all_by_story_id(params[:id])
    @submissions = Submission.by_vote.find_all_by_story_id(params[:id])
    @new_submission = Submission.new
    # To display latest story upon completion of previous story. 
    @last_story_id = Story.last.id
  end
  


  def update
    top_line_vote_count = Submission.by_vote.find_all_by_story_id(params[:id]).first.vote
    if Submission.find_all_by_story_id(params[:id]).count > 1
      second_line_vote_count = Submission.by_vote.find_all_by_story_id(params[:id])[1].vote
    else
      second_line_vote_count = 0
    end
    
    vote_total = 0
    submissions = Submission.by_vote.find_all_by_story_id(params[:id])
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
    elsif top_line_vote_count.to_i >= (10 - vote_total) + second_line_vote_count.to_i && Line.find_all_by_story_id(params[:id]).count == 9
        submission_to_line_create_new_story
    elsif top_line_vote_count.to_i >= (10 - vote_total) + second_line_vote_count.to_i || vote_total == 9 
      submission_to_line
    elsif Submission.find_all_by_story_id(params[:id]).empty? || Submission.find_by_id(params[:submission_id]).nil?
      #FLASH NOTICE
      redirect_to story_url
    else
      submit_vote
    end
  end
end
