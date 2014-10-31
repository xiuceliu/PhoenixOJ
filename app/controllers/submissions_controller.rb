class SubmissionsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index , :showall, :show]
  
  def showall
    @submissions = Submission.all
  end

  def index
    @problem = Problem.find(params[:problem_id])
    @submissions = @problem.submissions
  end

  def show
    @problem = Problem.find(params[:problem_id])
    @submission = @problem.submissions.find(params[:id])
  end

  def create
    @problem = Problem.find(params[:problem_id])
    @submission = Submission.new(params[:submission])
    @submission.problem = @problem
    @submission.user = current_user
    @submission.save
    redirect_to problem_submissions_path(@problem)
  end

  def destroy
    @problem = Problem.find(params[:problem_id])
    @submission = @problem.submissions.find(params[:id])
    @submission.destroy
    redirect_to problem_submissions_path(@problem)
  end

end
