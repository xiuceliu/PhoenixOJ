class ProblemsController < ApplicationController
  # GET /problems
  # GET /problems.json
  require 'will_paginate/array'
  def index
    @problems = Problem.search(params[:kwd], params[:src]).paginate :page => params[:page], :per_page => 25
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem = Problem.find(params[:id])
    @submission = Submission.new(params[:submission])

    if @problem.ptype == "Codeforces" then

      @str = Nokogiri::HTML(File.open("Problems/Codeforces/#{@problem.pid}.txt", "r+"))
# Get Time Limit
  @str_tml = @str.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.header div.time-limit").text
  @tml = @str_tml.gsub!(/\D/, "").to_i * 1000
# Get Memory Limit
  @str_mml = @str.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.header div.memory-limit").text
  @mml = @str_mml.gsub!(/\D/, "").to_i
# Get Description
  @str_des = @str.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div:nth-child(2) p,
  html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div:nth-child(2) ul")
# Get Input
  @str_input = @str.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.input-specification p,
  html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.input-specification ul")
# Get Output
  @str_output = @str.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.output-specification p,
  html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.output-specification ul")
# Get Sample
  @str_sample = @str.css("html body div#body div div#content.content-with-sidebar div.problemindexholder div.ttypography div.problem-statement div.sample-tests div.sample-test")
    elsif @problem.ptype == "Hdu" then

@tml = 1000; @mml = 256
agent = Nokogiri::HTML(File.open("Problems/Hdu/#{@problem.pid}.txt", "r+"))
str = agent.css(".panel_content")
@str_des = str[0].to_s
@str_input = str[1].to_s
@str_output = str[2].to_s
@str_sample = "<h4>Sample Input</h4>" + str[3].to_s + "<h4>Sample Output</h4>" + str[4].to_s

    end




    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/new
  # GET /problems/new.json
  def new
    @problem = Problem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(params[:problem])

    respond_to do |format|
      if @problem.save
        format.html { redirect_to @problem, notice: 'Problem was successfully created.' }
        format.json { render json: @problem, status: :created, location: @problem }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.json
  def update
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to @problem, notice: 'Problem was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to problems_url }
      format.json { head :no_content }
    end
  end
end
