class SubmissionsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:index , :showall, :show]

  # require 'will_paginate/array'

  def index
    @submissions = Submission.search(params[:pid], params[:usn]).paginate :page => params[:page], :per_page => 3
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
