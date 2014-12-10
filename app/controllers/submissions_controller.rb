require 'json'
require 'open-uri'

def submit_to_codeforces(index, source, language)
  agent = Mechanize.new

# Login
  agent.get("http://codeforces.com/enter")
  form = agent.page.forms[1]
  form.handle = "PhoenixOJ"
  form.password = "woshilalala"
  form.click_button
  page = agent.get("http://codeforces.com/problemset/submit")

# Submit Code
  form = agent.page.forms[1]
  form.submittedProblemCode = index
  form.source = source
  case language
  when "GNU C++ 4.7" then form.programTypeId = "1"
  when "Java 7" then form.programTypeId = "23"
  when "Python 2.7" then form.programTypeId = "7"
  when "Ruby 2" then form.programTypeId = "8"
  end
  form.fields.each {|f| puts f.name}
  form.click_button
end

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
    if(@problem.ptype == "CF") then
      submit_to_codeforces(@problem.pid, @submission.code, @submission.language)
      begin
        str = open("http://codeforces.com/api/user.status?handle=PhoenixOJ&from=1&count=1").string
        hash = JSON.parse str
      end until hash["result"][0]["verdict"] && hash["result"][0]["verdict"] != "TESTING"
      case hash["result"][0]["verdict"]
      when "OK" then @submission.verdict = ARR_VERDICT[1]
      when "WRONG_ANWSER" then @submission.verdict = ARR_VERDICT[2]
      when "TIME_LIMIT_EXCEEDED" then @submission.verdict = ARR_VERDICT[3]
      when "MEMORY_LIMIT_EXCEEDED" then @submission.verdict = ARR_VERDICT[4]
      when "COMPILATION_ERROR" then @submission.verdict = ARR_VERDICT[5]
      when "RUNTIME_ERROR" then @submission.verdict = ARR_VERDICT[6]
      when "PRESENTATION_ERROR" then @submission.verdict = ARR_VERDICT[7]
      end
      @submission.problem = @problem
      @submission.user = current_user
      @submission.timeConsumedMillis = hash["result"][0]["timeConsumedMillis"]
      @submission.memoryConsumedBytes = hash["result"][0]["memoryConsumedBytes"]
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
