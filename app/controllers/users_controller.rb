class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@arr0 = @user.arr_prosolved.sort
		@arr1 = @user.arr_profailed.sort
	end
end
