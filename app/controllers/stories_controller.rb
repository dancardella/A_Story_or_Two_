# TO DO:
# Call me Ishmael
# Refactor Controller into models/views/helpers
# Build collection of story lines to insert into the first line of newly created stories. 


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
    
    # Starting to repeat a bit, maybe this can be done a better way.
    
    @vote_total = 10
    @submissions_votes = Submission.find_all_by_story_id(params[:id])
    @submissions_votes.each do |submission|
    @vote_total -= submission.vote 
   @user=User.find_by_id(params[:user_id])
    end
# <<<<<<< HEAD:app/controllers/story_controller.rb
=======
    @last_story_object = Story.last
    @last_story_id = @last_story_object.id
# >>>>>>> 4551dacea72d8fa835f574557527629399108127:app/controllers/stories_controller.rb
  end
  
  def update
    # @user=User.find_by_id(params[:user_id])
    #              if @user.timestamp && Time.now - @user.timestamp < 3600
    #              flash[:notice] = "Only 1 Vote per Hour / Story Please"
    #              render stories_url  
    #                elsif
    #                timestamp(user)
        @vote_total = 0
        @submissions = Submission.find_all_by_story_id(params[:id])
        @submissions.each do |submission|
        @vote_total += submission.vote
        end

# <<<<<<< HEAD:app/controllers/story_controller.rb
    if @vote_total == 9 #elsif
    if @vote_total == 9 && Line.find_all_by_story_id(params[:id]).count == 9
      @newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      @newline = @newlines.first
      line = Line.new
      line.content = @newline.content
      line.story_id = params[:id]
      line.save
      Submission.scoped({:conditions => ['story_id = ?', params[:id] ]}).destroy_all
      create_story
      redirect_to story_url
    elsif @vote_total == 9
# >>>>>>> 4551dacea72d8fa835f574557527629399108127:app/controllers/stories_controller.rb
      @newlines = Submission.by_vote.find_all_by_story_id(params[:id])
      @newline = @newlines.first
      line = Line.new
      line.content = @newline.content
      line.story_id = params[:id]
      line.save
      Submission.scoped({:conditions => ['story_id = ?', params[:id] ]}).destroy_all
      redirect_to story_url
    elsif Submission.find_all_by_story_id(params[:id]).empty? || Submission.find_by_id(params[:submission_id]).nil?
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
