require 'will_paginate/array'

class NewsController < ApplicationController
	before_filter :authenticate_user!, :except => [:index, :show]
	def index
		@news = News.all.sort_by {|u| u.id}
		@news = @news.reverse
		@news = @news.paginate :page => params[:page], :per_page => 25
		@newnews = News.new
	end
	def show
		@news = News.find(params[:id])
	end
	def edit
		@news = News.find(params[:id])
	end
	def create
		@news = News.new(params[:news])
		@news.user = current_user
		@news.save
		redirect_to news_index_path
	end
	def update
    @news = News.find(params[:id])
    @news.update_attributes(params[:news])
    redirect_to news_index_path
  end
	def destroy
    @news = News.find(params[:id])
    @news.destroy
    redirect_to news_index_path
  end
end
