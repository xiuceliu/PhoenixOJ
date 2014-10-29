class DiscussesController < ApplicationController
	def index
		@problem = Problem.find(params[:problem_id])
		@discusses = @problem.discusses
	end
	def create
		@problem = Problem.find(params[:problem_id])
		@discuss = @problem.discusses.create(params[:discuss])
		redirect_to problem_path(@problem)
	end
	def destroy
    	@problem = Problem.find(params[:problem_id])
    	@discuss = @problem.discusses.find(params[:id])
    	@discuss.destroy
    	redirect_to problem_path(@problem)
  	end
end
