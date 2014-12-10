require 'json'
require 'open-uri'

def submit_to_codeforces(index, source)
  agent = Mechanize.new

# Login
  agent.get("http://codeforces.com/enter")
  form = agent.page.forms[1]
  form.handle = "for_the_money"
  form.password = "beyblade!@#@!"
  form.click_button
  page = agent.get("http://codeforces.com/problemset/submit")

# Submit Code
  form = agent.page.forms[1]
  form.submittedProblemCode = index
  form.source = source
  form.programTypeId = "1"
  form.fields.each {|f| puts f.name}
  form.click_button
end

class SubmissionsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index , :showall, :show]

  require 'will_paginate/array'

  def index
    
    @submissions = Submission.search(params[:pid], params[:usn], params[:res], params[:lan]).paginate :page => params[:page], :per_page => 10
  end

  def show
    @problem = Problem.find(params[:problem_id])
    @submission = @problem.submissions.find(params[:id])
  end

  def create
    @problem = Problem.find(params[:problem_id])
    @submission = Submission.new(params[:submission])
    if(@problem.ptype == "CF") then
      submit_to_codeforces(@problem.pid, @submission.code)
      @submission.problem = @problem
      @submission.user = current_user
      begin
        str = open("http://codeforces.com/api/user.status?handle=for_the_money&from=1&count=1").string
        hash = JSON.parse str
        @submission.verdict = hash["result"][0]["verdict"]
        @submission.timeConsumedMillis = hash["result"][0]["timeConsumedMillis"]
        @submission.memoryConsumedBytes = hash["result"][0]["memoryConsumedBytes"]
      end until hash["result"][0]["verdict"] && hash["result"][0]["verdict"] != "TESTING"
      @submission.save
    end
    redirect_to problem_submissions_path(@problem)
  end

  def destroy
    @problem = Problem.find(params[:problem_id])
    @submission = @problem.submissions.find(params[:id])
    @submission.destroy
    redirect_to problem_submissions_path(@problem)
  end

end
