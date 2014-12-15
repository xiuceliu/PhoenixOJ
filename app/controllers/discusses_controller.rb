class DiscussesController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show]
	def index
		@problem = Problem.find(params[:problem_id])
		@discusses = @problem.discusses
		@newdiscuss = Discuss.new
	end
	def show
		@problem = Problem.find(params[:problem_id])
		@discuss = @problem.discusses.find(params[:id])
		@newdiscuss = Discuss.new(:parent_id => params[:parent_id])
	end
	def edit
		@problem = Problem.find(params[:problem_id])	
		@discuss = @problem.discusses.find(params[:id])
	end
	def new
	  	# @problem = Problem.find(params[:problem_id])
	  	# @discuss = Discuss.new(:parent_id => params[:parent_id])
  end
	def create
		@problem = Problem.find(params[:problem_id])
		@discuss = Discuss.new(params[:discuss])
		@discuss.problem = @problem
		@discuss.user = current_user
		@discuss.save
		redirect_to problem_discusses_path(@problem)
	end
	def destroy
    	@problem = Problem.find(params[:problem_id])
    	@discuss = @problem.discusses.find(params[:id])
    	@discuss.destroy
    	redirect_to problem_discusses_path(@problem)
  	end
end
