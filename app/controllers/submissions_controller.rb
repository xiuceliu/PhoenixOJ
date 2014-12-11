class SubmissionsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index , :showall, :show]

  require 'will_paginate/array'

  def index
    @submissions = Submission.search(params[:pid], params[:usn], params[:res], params[:lan]).paginate :page => params[:page], :per_page => 25
  end

  def show
    @problem = Problem.find(params[:problem_id])
    @submission = @problem.submissions.find(params[:id])
  end

# Submitting a code
  def create
    @problem = Problem.find(params[:problem_id])
    @submission = Submission.new(params[:submission])
    @submission.verdict = "Running"
    @submission.problem = @problem
    @submission.user = current_user
    @submission.timeConsumedMillis = 0
    @submission.memoryConsumedBytes = 0
    @submission.save
    system "bundle exec rake submit_problem_to_codeforces SUB_ID=#{@submission.id} &"
    redirect_to problem_submissions_path(@problem)
  end

  def destroy
    @problem = Problem.find(params[:problem_id])
    @submission = @problem.submissions.find(params[:id])
    @submission.destroy
    redirect_to problem_submissions_path(@problem)
  end

end
