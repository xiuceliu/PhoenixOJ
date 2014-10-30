class DiscussesController < ApplicationController
	def index
		@problem = Problem.find(params[:problem_id])
		@discusses = @problem.discusses
	end
	def show
		@problem = Problem.find(params[:problem_id])
		@discuss = @problem.discusses.find(params[:id])
	end
	def edit
		@problem = Problem.find(params[:problem_id])	
		@discuss = @problem.discusses.find(params[:id])
	end
	def new
	  	@problem = Problem.find(params[:problem_id])
	  	@discuss = Discuss.new
  	end
	def create
		@problem = Problem.find(params[:problem_id])
		@discuss = @problem.discusses.create(params[:discuss])
		redirect_to problem_discusses_path(@problem)
	end
	def destroy
    	@problem = Problem.find(params[:problem_id])
    	@discuss = @problem.discusses.find(params[:id])
    	@discuss.destroy
    	redirect_to problem_discusses_path(@problem)
  	end
end
