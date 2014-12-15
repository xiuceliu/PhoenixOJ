class UsersController < ApplicationController
	def index
		 @users = User.all.sort_by {|u| u.arr_prosolved.length}
		 @users = @users.reverse
		 @users = @users.paginate :page => params[:page], :per_page => 25

	end
	def show
		@user = User.find(params[:id])
		@arr0 = @user.arr_prosolved.sort
		@arr1 = @user.arr_profailed.sort
	end
end
